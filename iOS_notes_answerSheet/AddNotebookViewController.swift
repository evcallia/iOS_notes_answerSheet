//
//  AddNotebookViewController.swift
//  iOS_notes_answerSheet
//
//  Created by Evan Callia on 3/2/17.
//  Copyright © 2017 Evan Callia. All rights reserved.
//

import UIKit

class AddNotebookViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // MARK: - Outlets
    @IBOutlet weak var titleInput: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    let imagePicker = UIImagePickerController()
    
    
    
    
    // MARK: - Variables
    weak var delegate: AddNotebookViewControllerDelegate?
    weak var cancelButtonDelegate: CancelButtonDelegate?
    
    
    
    
    
    // MARK: - User Actions
    @IBAction func addImagePressed(_ sender: UIButton) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func cancelPressed(_ sender: UIBarButtonItem) {
        cancelButtonDelegate?.cancelButtonPressed(by: self)
    }
    
    @IBAction func donePressed(_ sender: UIBarButtonItem) {
        let data = UIImageJPEGRepresentation(imageView.image!, 1)! as NSData
        delegate?.notebookAdded(by: self, with: titleInput.text!, andImage: data)
    }
    
    
    
    
    // MARK: - Image picker delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            imageView.contentMode = .scaleToFill
            imageView.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
    }
}














