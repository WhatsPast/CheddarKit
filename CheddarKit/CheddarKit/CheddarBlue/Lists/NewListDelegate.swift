//
//  NewListDelegate.swift
//  CheddarKit
//
//  Created by Karl Weber on 4/5/18.
//  Copyright © 2018 Karl Weber. All rights reserved.
//

/*
 The new List Delegate handles all of the events triggered by the new list
 text field in the listViewController, including animations.
 */

import UIKit

class NewListDelegate: NSObject, UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
//        textField.showShaddow()
        textField.activeState()
        // animate up because of the keyboard
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        textField.inactiveState()
        return true
    }
    
}
