//
//  AddNotebookViewControllerDelegate.swift
//  iOS_notes_answerSheet
//
//  Created by Evan Callia on 3/2/17.
//  Copyright © 2017 Evan Callia. All rights reserved.
//

import Foundation

protocol AddNotebookViewControllerDelegate: class {
    func notebookAdded(by controller: AddNotebookViewController, with title: String, andImage data: NSData)
}
