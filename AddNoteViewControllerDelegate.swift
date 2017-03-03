//
//  AddNoteViewControllerDelegate.swift
//  iOS_notes_answerSheet
//
//  Created by Evan Callia on 3/2/17.
//  Copyright © 2017 Evan Callia. All rights reserved.
//

import Foundation

protocol AddNoteViewControllerDelegate: class {
    func noteAdded(by controller: AddNoteViewController, with title: String, and text: String)
}
