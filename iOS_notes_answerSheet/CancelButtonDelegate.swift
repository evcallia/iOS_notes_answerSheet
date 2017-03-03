//
//  CancelButtonDelegate.swift
//  iOS_notes_answerSheet
//
//  Created by Evan Callia on 3/2/17.
//  Copyright © 2017 Evan Callia. All rights reserved.
//

import Foundation
import UIKit

protocol CancelButtonDelegate: class {
    func cancelButtonPressed(by controller: UIViewController)
}
