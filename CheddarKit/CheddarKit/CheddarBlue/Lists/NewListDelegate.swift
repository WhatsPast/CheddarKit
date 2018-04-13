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
    
    var textField: UITextField?
    var keyboardHeight: CGFloat = 0.0
    var bottomConstraint: NSLayoutConstraint?
    
    override init() {
        super.init()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
//        setupConstraints()
    }
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            keyboardHeight = keyboardRectangle.height
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        DispatchQueue.main.async {
            self.setToActiveState()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        DispatchQueue.main.async {
            self.setToInactiveState()
            if textField.text != nil {
                self.cheddarMakeList(textField.text!)
            }
        }
        return true
    }
    
    func setupConstraints() {
        bottomConstraint = textField?.bottomAnchor.constraint(equalTo: (textField?.superview?.bottomAnchor)!, constant: -16.0)
        bottomConstraint?.isActive = true
    }
    
    // MARK: Mutations / Animations of State
    func setToActiveState() {
        textField?.activeState()
        // animate up because of the keyboard
        UIView.animate(withDuration: 0.20) {
            self.bottomConstraint?.constant = -(self.keyboardHeight + 16)
            self.textField?.layoutIfNeeded()
            self.textField?.superview?.layoutIfNeeded()
            self.textField?.backgroundColor = .white
        }
    }
    
    func setToInactiveState() {
        textField?.resignFirstResponder()
        textField?.inactiveState()
        UIView.animate(withDuration: 0.5) {
            self.bottomConstraint?.constant = -16.0
            self.textField?.layoutIfNeeded()
            self.textField?.superview?.layoutIfNeeded()
            self.textField?.backgroundColor = .whiteThree
        }
    }
    
    
    // MARK: Database and Network stuff.
    func cheddarMakeList(_ title: String) {
        CheddarKit.sharedInstance.createList(title: title) { (list, error) in
            if let error = error {
                print("error: \(error.error)")
                DispatchQueue.main.async {
                    self.setToActiveState()
                }
            }
            if list != nil {
                print("We've got a new list!!!!")
                
                DispatchQueue.main.async {
                    self.textField?.text = ""
                    self.setToInactiveState()
                }
            }
        }
    }
    
}
