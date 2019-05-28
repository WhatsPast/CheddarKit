//
//  LoginDelegate.swift
//  CheddarKit
//
//  Created by Karl Weber on 5/28/19.
//  Copyright © 2019 Karl Weber. All rights reserved.
//

import UIKit

class LoginDelegate: NSObject, UITextFieldDelegate {
    
    var keyboardHeight: CGFloat = 0.0
    var bottomConstraint: NSLayoutConstraint?
    
    override init() {
        super.init()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    // MARK: TextFieldDelegate stuff
    @objc func keyboardWillShow(_ notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            keyboardHeight = keyboardRectangle.height
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        DispatchQueue.main.async {
            self.setToActiveState(textField)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        DispatchQueue.main.async {
            self.setToInactiveState(textField)
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        DispatchQueue.main.async {
            self.setToInactiveState(textField)
        }
    }
    
    // MARK: Mutations / Animations of State
    func setToActiveState(_ textField: UITextField) {
        textField.activeState()
        // animate up because of the keyboard
        UIView.animate(withDuration: 0.20) {
            textField.backgroundColor = .white
        }
    }
    
    func setToInactiveState(_ textField: UITextField) {
        textField.resignFirstResponder()
        textField.inactiveState()
        UIView.animate(withDuration: 0.5) {
            textField.backgroundColor = .whiteThree
        }
    }
    
}
