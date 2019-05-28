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
    var newListDelegate: MagicTextFieldDelegate?
    
    // for moving cells
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = ""
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = false
        
        setupBackgroundDismissButton()
        setupBackgroundView()
        setupButtons()
        setupMagicTextField()
    }
    
    // Setup Views and UI
    func setupBackgroundDismissButton() {
        backgroundDismissButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(backgroundDismissButton)
        
        backgroundDismissButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0.0).isActive = true
        backgroundDismissButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0.0).isActive = true
        backgroundDismissButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 0.0).isActive = true
        backgroundDismissButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0.0).isActive = true
        
        backgroundDismissButton.backgroundColor = .clear
        backgroundDismissButton.isUserInteractionEnabled = false
        backgroundDismissButton.setTitle("", for: .normal)
    }
    
    func setupBackgroundView() {
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(backgroundView)
        backgroundView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0.0).isActive = true
        backgroundView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0.0).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0.0).isActive = true
        backgroundView.heightAnchor.constraint(equalToConstant: 88).isActive = true
        
        backgroundView.backgroundColor = .whiteSeven
    }
    
    func setupButtons() {
        
    }
    
    func setupMagicTextField() {
        
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
