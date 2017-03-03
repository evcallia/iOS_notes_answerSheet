//
//  ShowNotebookTableViewController.swift
//  iOS_notes_answerSheet
//
//  Created by Evan Callia on 3/2/17.
//  Copyright © 2017 Evan Callia. All rights reserved.
//

import UIKit

class ShowNotebookTableViewController: UITableViewController, CancelButtonDelegate, AddNoteViewControllerDelegate {

    // MARK: - Variables
    var notebook: Notebook!
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    
    
    // MARK: - User actions
    @IBAction func addNotePressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "addNote", sender: sender)
    }
    
    
    
    
    // MARK: - Cancel button delegate
    func cancelButtonPressed(by controller: UIViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    // MARK: - Add Note delegate
    func noteAdded(by controller: AddNoteViewController, with title: String, and text: String) {
        dismiss(animated: true, completion: nil)
        let note = Note(context: managedObjectContext)
        note.title = title
        note.text = text
        notebook.addToNotes(note)
        saveData()
        tableView.reloadData()
    }
    
    
    

    // MARK: - Table View data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notebook.notes!.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath)
        cell.textLabel?.text = (notebook.notes![indexPath.row] as! Note).title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showNote", sender: notebook.notes![indexPath.row])
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        notebook.removeFromNotes(notebook.notes![indexPath.row] as! Note)
        saveData()
        tableView.reloadData()
    }
    
    
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addNote"{
            let navController = segue.destination as! UINavigationController
            let controller = navController.topViewController as! AddNoteViewController
            controller.cancelButtonDelegate = self
            controller.delegate = self
        }else if segue.identifier == "showNote"{
            let controller = segue.destination as! ShowNoteViewController
            controller.note = sender as! Note
        }
    }
    
    
    
    
    // MARK: - CORE DATA METHODS
    func saveData(){
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                print("\(error)")
            }
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}










