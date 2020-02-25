//
//  ListsActionsDelegate.swift
//  CheddarKit
//
//  Created by Karl Weber on 5/31/19.
//  Copyright © 2019 Karl Weber. All rights reserved.
//
//
// The List Actions Delegate is like the logic behind the Lists View Controller.
// It makes decisions based on user interface actions that happen in the View Controller.
// Remember the ViewController should only handle the presentation and animation, and
// shouldn't make decisions about navigation or data.
//

import UIKit

class ListActionsDelegate: MagicTextFieldDelegate {
    
    // we make this weak to avoid retain cycles
    weak var parentListViewController: ListsViewController?
    
    init() {
        // init this puppy.
    }
    
    // So when the magic text field is dismissed, we usually do nothing.
    // but perhaps we want to save the state of the magic text field for this particular
    // list or groups of lists. That's why we got this here.
    func didDismissMagicText(from: MagicTextField) {
        // probably do nothing
    }
    
    // When we cancel the Magic text field we probably want to capture the state for later.
    // or do nothing.
    func didCancelMagicText(from: MagicTextField) {
        // also probably do nothing
    }
    
    // When we tap on Save for the magic textField we'll want to preserve which List is making
    // this save, what the text is/was and then probably fire off a save action.
    // if the save action fails we'll do it again, or inform the user of a failure and
    // restore the text to the old text field.
    // in this case, we're gonna try to make a new List, and if it fails then bummer.
    func didSaveMagicText(withText: String, from: MagicTextField) {
        // create a new list action object.
        // add it to the action queue
        // save it in the caching database (realm)
        // be happy.
    }
    
}

// to handle the mov
extension ListActionsDelegate {
    
}
