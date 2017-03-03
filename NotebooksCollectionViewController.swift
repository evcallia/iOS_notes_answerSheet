//
//  NotebooksCollectionViewController.swift
//  iOS_notes_answerSheet
//
//  Created by Evan Callia on 3/2/17.
//  Copyright © 2017 Evan Callia. All rights reserved.
//

import UIKit

private let reuseIdentifier = "notebookCell"

class NotebooksCollectionViewController: UICollectionViewController, AddNotebookViewControllerDelegate, CancelButtonDelegate, UIGestureRecognizerDelegate {

    // MARK: - Variables
    var notebooks = [Notebook]()
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    
    
    // MARK: - User Actions
    @IBAction func addPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "addNotebook", sender: sender)
    }
    
    
    
    
    // MARK: - Cancel button delegate
    func cancelButtonPressed(by controller: UIViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    // MARK: - Add Notebook delegate
    func notebookAdded(by controller: AddNotebookViewController, with title: String, andImage data: NSData) {
        dismiss(animated: true, completion: nil)
        let notebook = Notebook(context: managedObjectContext)
        notebook.title = title
        notebook.image = data
        saveData()
        notebooks.append(notebook)
        collectionView?.reloadData()
    }
    
    
    
    
    // MARK: - UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return notebooks.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! NotebookCollectionViewCell
        cell.titleLabel.text = notebooks[indexPath.row].title
        cell.imageView.image = UIImage(data: notebooks[indexPath.row].image as! Data)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showNotebook", sender: notebooks[indexPath.row])
    }
    
    
    
    
    //MARK: - UIGesture Recognizer Delegate
    func handleLongPress(_ gestureReconizer: UILongPressGestureRecognizer) {
        if gestureReconizer.state != UIGestureRecognizerState.began {
            return
        }
        let p = gestureReconizer.location(in: collectionView)
        let indexPath = collectionView?.indexPathForItem(at: p)
        managedObjectContext.delete(notebooks[(indexPath?.row)!])
        saveData()
        notebooks.remove(at: (indexPath?.row)!)
        collectionView?.reloadData()
    }
    
    
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navController = segue.destination as! UINavigationController
        if segue.identifier == "addNotebook"{
            let controller = navController.topViewController as! AddNotebookViewController
            controller.delegate = self
            controller.cancelButtonDelegate = self
        }else if segue.identifier == "showNotebook"{
            let controller = navController.topViewController as! ShowNotebookTableViewController
            controller.notebook = sender as! Notebook
        }
    }
    
    
    
    
    // MARK: - CORE DATA METHODS
    func fetchAllNotebooks(){
        do {
            let results = try managedObjectContext.fetch(Notebook.fetchRequest())
            notebooks = results as! [Notebook]
        } catch {
            print("\(error)")
        }
    }
    
    func saveData(){
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                print("\(error)")
            }
        }
    }
    
    
    
    
    // Unwind Segue
    @IBAction func unwindToNotebooks(segue: UIStoryboardSegue){}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let lpgr = UILongPressGestureRecognizer(target: self, action: #selector(NotebooksCollectionViewController.handleLongPress(_:)))
        lpgr.minimumPressDuration = 0.5
        lpgr.delaysTouchesBegan = true
        lpgr.delegate = self
        self.collectionView?.addGestureRecognizer(lpgr)
        fetchAllNotebooks()
    }
}











