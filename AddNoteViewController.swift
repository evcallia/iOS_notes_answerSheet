//
//  AddNoteViewController.swift
//  iOS_notes_answerSheet
//
//  Created by Evan Callia on 3/2/17.
//  Copyright © 2017 Evan Callia. All rights reserved.
//

import UIKit

class AddNoteViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var titleInput: UITextField!
    @IBOutlet weak var textInput: UITextView!
    
    
    
    
    // MARK: - Variables
    weak var delegate: AddNoteViewControllerDelegate?
    weak var cancelButtonDelegate: CancelButtonDelegate?
    
    
    
    
    // MARK: - User Actions
    @IBAction func donePressed(_ sender: UIBarButtonItem) {
        delegate?.noteAdded(by: self, with: titleInput.text!, and: textInput.text)
    }
    
    @IBAction func cancelPressed(_ sender: UIBarButtonItem) {
        cancelButtonDelegate?.cancelButtonPressed(by: self)
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}











