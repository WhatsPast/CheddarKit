//
//  MagicTextFieldViewController.swift
//  CheddarKit
//
//  Created by Karl Weber on 5/21/19.
//  Copyright © 2019 Karl Weber. All rights reserved.
//

import UIKit

/*
    The MagicTextField, is quite magical. It's intended to sit at the bottom
    of another viewController waiting to be tapped. It then "grows" to fill up
    the bottom half of the screen. It's got a cancel button, a save button, and
    a grey background.
 */
class MagicTextFieldViewController: UIViewController {
    
    // Views
    var textInputField = TextField()
    var saveButton = UIButton()
    var cancelButton = UIButton()
    var backgroundView = UIView()
    var backgroundDismissButton = UIButton()
    var delegate: MagicTextFieldDelegate?
    
    // for changing the height of the background and stuff
    var backgroundDismissButtonHeightConstraintTall: NSLayoutConstraint?
    var backgroundDismissButtonHeightConstraintShort: NSLayoutConstraint?
    
    // for changing the height of the whole damn view
    var viewHeightConstraintTall: NSLayoutConstraint?
    var viewHeightConstraintShort: NSLayoutConstraint?
    
    // for changing the position of the background View
    var backgroundViewHeightConstraintTall: NSLayoutConstraint?
    var backgroundViewHeightConstraintShort: NSLayoutConstraint?
    
    // for changing the position of the textField
    var textFieldTopConstraintActive: NSLayoutConstraint?
    var textFieldTopConstraintInactive: NSLayoutConstraint?
    
    
    // the Keyboard Height
    var keyboardHeight: CGFloat = 0.0
    var keyboardHeightLayoutConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = ""
        view.backgroundColor = .clear
//        view.isUserInteractionEnabled = false
        
//        if newListDelegate == nil {
//            newListDelegate = MagicTextFieldDelegate()
//        }
        
        setupBackgroundDismissButton()
        setupBackgroundView()
        setupMagicTextField()
        setupButtons()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardNotification), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    // Setup Views and UI
    func setupBackgroundDismissButton() {
        backgroundDismissButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(backgroundDismissButton)
        backgroundDismissButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0.0).isActive = true
        backgroundDismissButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0.0).isActive = true
        backgroundDismissButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0.0).isActive = true
        backgroundDismissButton.backgroundColor = .clear
        backgroundDismissButton.isUserInteractionEnabled = true
        backgroundDismissButton.setTitle("", for: .normal)
        backgroundDismissButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        
        // setup the height constraints
        backgroundDismissButtonHeightConstraintTall = backgroundDismissButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 0.0)
        backgroundDismissButtonHeightConstraintShort = backgroundDismissButton.heightAnchor.constraint(equalToConstant: 1.0)
        
        // activate the height constraint
        backgroundDismissButtonHeightConstraintShort?.isActive = true
    }
    
    func setupBackgroundView() {
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(backgroundView)
        backgroundView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0.0).isActive = true
        backgroundView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0.0).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0.0).isActive = true
        
        backgroundViewHeightConstraintShort = backgroundView.heightAnchor.constraint(equalToConstant: 88)
        backgroundViewHeightConstraintShort?.isActive = true
        
        backgroundView.backgroundColor = .whiteSeven
    }
    
    func setupButtons() {
        
        // save button
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.addSubview(saveButton)
        saveButton.widthAnchor.constraint(equalToConstant: 64.0).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 32.0).isActive = true
        saveButton.rightAnchor.constraint(equalTo: backgroundView.rightAnchor, constant: -10.0).isActive = true
        saveButton.topAnchor.constraint(equalTo: textInputField.bottomAnchor, constant: 8.0).isActive = true
        saveButton.setTitle("Save", for: .normal)
        saveButton.layer.cornerRadius = 11
        saveButton.backgroundColor = .blueOne
        self.saveButton.layer.opacity = 0.0
        
        // cancel button
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.addSubview(cancelButton)
        cancelButton.widthAnchor.constraint(equalToConstant: 74.0).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 32.0).isActive = true
        cancelButton.rightAnchor.constraint(equalTo: saveButton.leftAnchor).isActive = true
        cancelButton.topAnchor.constraint(equalTo: textInputField.bottomAnchor, constant: 8.0).isActive = true
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.backgroundColor = .clear
        cancelButton.setTitleColor(.blueOne, for: .normal)
        self.cancelButton.layer.opacity = 0.0
    }
    
    func setupMagicTextField() {
        textInputField.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.addSubview(textInputField)
        textInputField.leftAnchor.constraint(equalTo: backgroundView.leftAnchor, constant: 10.0).isActive = true
        textInputField.rightAnchor.constraint(equalTo: backgroundView.rightAnchor, constant: -10.0).isActive = true
        textInputField.heightAnchor.constraint(equalToConstant: 32).isActive = true
        textInputField.delegate = self
//        textInputField.backgroundColor = .black
        textInputField.layer.cornerRadius = 10
        textInputField.backgroundColor = .whiteTwo
        textInputField.placeholder = "New List"
        view.bringSubviewToFront(textInputField)
        textInputField.isUserInteractionEnabled = true
        
        textFieldTopConstraintActive = textInputField.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 8)
        textFieldTopConstraintInactive = textInputField.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 28)
        textFieldTopConstraintInactive?.isActive = true
        
    }
    
    func layoutToBottomOf(_ superView: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.leftAnchor.constraint(equalTo: superView.leftAnchor).isActive = true
        view.rightAnchor.constraint(equalTo: superView.rightAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
        view.backgroundColor = .clear
        // setup the adjustable stuff
//        viewHeightConstraintTall = view.heightAnchor.constraint(equalTo: superView.heightAnchor)
        viewHeightConstraintShort = view.heightAnchor.constraint(equalToConstant: 88)
        viewHeightConstraintTall = view.heightAnchor.constraint(equalTo: superView.heightAnchor)
        viewHeightConstraintShort?.isActive = true
    }
    
    @objc func dismissView() {
        print("dismissView")
        setToInactiveState()
    }
    
}

extension MagicTextFieldViewController: MagicTextField {
    func clearText() {
        textInputField.text = ""
    }
    
    func loadText(_ text: String) {
        textInputField.text = text
    }
    
    func grow() {
        // change the textField from a shrunken to a grown state
    }
    
    func shrink() {
        //
    }
}

extension MagicTextFieldViewController: UITextFieldDelegate {
    
    @objc func keyboardNotification(_ notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let endFrameY = endFrame?.origin.y ?? 0
            let duration:TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
            let animationCurve:UIView.AnimationOptions = UIView.AnimationOptions(rawValue: animationCurveRaw)
            if endFrameY >= UIScreen.main.bounds.size.height {
                self.keyboardHeight = 0.0
            } else {
                self.keyboardHeight = endFrame?.size.height ?? 0.0
            }
            
            self.backgroundViewHeightConstraintShort?.isActive = false
            
            self.backgroundViewHeightConstraintTall = backgroundView.heightAnchor.constraint(equalToConstant: 88 + keyboardHeight)
            self.backgroundViewHeightConstraintTall?.isActive = true
            
            UIView.animate(withDuration: duration,
                           delay: TimeInterval(0),
                           options: animationCurve,
                           animations: { self.view.layoutIfNeeded() },
                           completion: nil)
        }
    }
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            keyboardHeight = keyboardRectangle.height
            backgroundViewHeightConstraintTall = backgroundView.heightAnchor.constraint(equalToConstant: 88 + keyboardHeight)
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
//                self.cheddarMakeList(textField.text!)
            }
        }
        return true
    }
    
    // MARK: Mutations / Animations of State
    func setToActiveState() {
        textInputField.activeState()
        // animate up because of the keyboard
        UIView.animate(withDuration: 0.30) {

            self.backgroundDismissButtonHeightConstraintShort?.isActive = false
            self.viewHeightConstraintShort?.isActive = false
            self.backgroundViewHeightConstraintShort?.isActive = false
            self.textFieldTopConstraintInactive?.isActive = false
            
            self.backgroundDismissButtonHeightConstraintTall?.isActive = true
            self.viewHeightConstraintTall?.isActive = true
            self.backgroundViewHeightConstraintTall?.isActive = true
            self.textFieldTopConstraintActive?.isActive = true
            
            self.textInputField.backgroundColor = .white
            
            self.saveButton.layer.opacity = 1.0
            self.cancelButton.layer.opacity = 1.0
            self.saveButton.isUserInteractionEnabled = true
            self.cancelButton.isUserInteractionEnabled = true
            
            
            self.view.superview?.layoutIfNeeded()
            self.view.layoutIfNeeded()
        }
    }
    
    func setToInactiveState() {
        textInputField.resignFirstResponder()
        textInputField.inactiveState()
        UIView.animate(withDuration: 0.5) {
            
            self.backgroundDismissButtonHeightConstraintTall?.isActive = false
            self.viewHeightConstraintTall?.isActive = false
            self.backgroundViewHeightConstraintTall?.isActive = false
            self.textFieldTopConstraintActive?.isActive = false
            
            self.backgroundDismissButtonHeightConstraintShort?.isActive = true
            self.viewHeightConstraintShort?.isActive = true
            self.backgroundViewHeightConstraintShort?.isActive = true
            self.textFieldTopConstraintInactive?.isActive = true
            
            self.textInputField.backgroundColor = .whiteTwo
            
            self.saveButton.layer.opacity = 0.0
            self.cancelButton.layer.opacity = 0.0
            self.saveButton.isUserInteractionEnabled = false
            self.cancelButton.isUserInteractionEnabled = false
            
            
            self.view.superview?.layoutIfNeeded()
            self.view.layoutIfNeeded()
        }
    }
    
}
