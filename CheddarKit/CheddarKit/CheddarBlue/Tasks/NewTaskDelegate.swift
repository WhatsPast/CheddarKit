//
//  NewTaskDelegate.swift
//  CheddarKit
//
//  Created by Karl Weber on 4/14/18.
//  Copyright © 2018 Karl Weber. All rights reserved.
//

import UIKit

class NewTaskDelegate: NSObject, UITextFieldDelegate {
    
    var textField: UITextField?
    var keyboardHeight: CGFloat = 0.0
    var bottomConstraint: NSLayoutConstraint?
    var list_id = 0
    
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
            self.setToActiveState()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        DispatchQueue.main.async {
            self.setToInactiveState()
            if textField.text != nil {
                self.cheddarMakeTask(textField.text!)
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
    func cheddarMakeTask(_ text: String) {
        CheddarKit.sharedInstance.create(taskWithText: text, forList: list_id, callback: {result in
            switch result {
            case .success:
                print("Task Created!")
                DispatchQueue.main.async {
                    self.textField?.text = ""
                    self.setToInactiveState()
                }
            case .failure(let error):
                print("ERROR: \(error.localizedDescription).")
                DispatchQueue.main.async {
                    self.setToActiveState()
                }
            }
        })
    }
    
}
