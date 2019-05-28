//
//  LoginViewController.swift
//  CheddarKit
//
//  Created by Karl Weber on 9/9/17.
//  Copyright © 2017 Karl Weber. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    let loginDelegate = LoginDelegate()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let usernameLabel = UILabel()
    let usernameField = TextField()
    let passwordLabel = UILabel()
    let passwordField = TextField()
    
    let button = UIButton()
    
    func setupViews() {
        
        self.view.backgroundColor = .appBackgroundColor
        
        self.view.addSubview(usernameLabel)
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100).isActive = true
        usernameLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        usernameLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 17).isActive = true
        usernameLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10).isActive = true
        usernameLabel.text = "Username"
        usernameLabel.font = UIFont.systemFont(ofSize: 12)
        usernameLabel.textColor = .black
        
        
        
        self.view.addSubview(usernameField)
        usernameField.translatesAutoresizingMaskIntoConstraints = false
        usernameField.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 5).isActive = true
        usernameField.heightAnchor.constraint(equalToConstant: 32).isActive = true
        usernameField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true
        usernameField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10).isActive = true
        usernameField.layer.cornerRadius = 10
        usernameField.backgroundColor = .whiteTwo
        usernameField.delegate = loginDelegate
        usernameField.placeholder = "Username"
        usernameField.autocorrectionType = .no
        usernameField.autocapitalizationType = .none
        usernameField.spellCheckingType = .no
        
        self.view.addSubview(passwordLabel)
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordLabel.topAnchor.constraint(equalTo: usernameField.bottomAnchor, constant: 20).isActive = true
        passwordLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        passwordLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 17).isActive = true
        passwordLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10).isActive = true
        passwordLabel.text = "Password"
        passwordLabel.font = UIFont.systemFont(ofSize: 12)
        passwordLabel.textColor = .black
        
        self.view.addSubview(passwordField)
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 5).isActive = true
        passwordField.heightAnchor.constraint(equalToConstant: 32).isActive = true
        passwordField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true
        passwordField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10).isActive = true
        passwordField.layer.cornerRadius = 10
        passwordField.backgroundColor = .whiteTwo
        passwordField.isSecureTextEntry = true
        passwordField.delegate = loginDelegate
        passwordField.placeholder = "Password"
        
        self.view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 50).isActive = true
        button.heightAnchor.constraint(equalToConstant: 32).isActive = true
        button.widthAnchor.constraint(equalToConstant: 120.0).isActive = true
        button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        button.layer.cornerRadius = 10
        button.setTitle("Sign In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blueOne
        button.addTarget(self, action: #selector(signIn), for: .touchUpInside)
        
    }
    
    @objc func signIn()  {
        print("signin")
        // Lock the UI.
        // Grab the username and password
        let user = usernameField.text!
        let pass = passwordField.text!
        CheddarKit.sharedInstance.login(username: user, password: pass, callback: { result in
            switch result {
            case .success(let token):
                print("We've got a new Token: \(token).")
                if CheddarKit.sharedInstance.setUserSessionWith(token) {
                    // we're officially logged in so let's show us some lists.
                    DispatchQueue.main.async {
                        let app = UIApplication.shared.delegate
                        (app as! AppDelegate).loadApplication()
                    }
                }
            case .failure(let error):
                print("We failed to login: \(error.localizedDescription)")
            }
        })
    }

}
