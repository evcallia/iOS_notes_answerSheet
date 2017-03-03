//
//  ShowNoteViewController.swift
//  iOS_notes_answerSheet
//
//  Created by Evan Callia on 3/2/17.
//  Copyright © 2017 Evan Callia. All rights reserved.
//

import UIKit

class ShowNoteViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    
    
    
    
    // MARK: - Variables
    var note: Note!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = note.title
        noteLabel.text = note.text
    }
}
