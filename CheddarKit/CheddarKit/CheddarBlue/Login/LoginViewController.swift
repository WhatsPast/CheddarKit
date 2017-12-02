//
//  LoginViewController.swift
//  CheddarKit
//
//  Created by Karl Weber on 9/9/17.
//  Copyright © 2017 Karl Weber. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

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
        
        self.view.backgroundColor = .white
        
        self.view.addSubview(usernameLabel)
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100).isActive = true
        usernameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        usernameLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true
        usernameLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10).isActive = true
        usernameLabel.text = "Username"
        usernameLabel.textColor = .black
        
        self.view.addSubview(usernameField)
        usernameField.translatesAutoresizingMaskIntoConstraints = false
        usernameField.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 5).isActive = true
        usernameField.heightAnchor.constraint(equalToConstant: 44).isActive = true
        usernameField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true
        usernameField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10).isActive = true
        usernameField.layer.cornerRadius = 10
        usernameField.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)
        
        self.view.addSubview(passwordLabel)
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordLabel.topAnchor.constraint(equalTo: usernameField.bottomAnchor, constant: 20).isActive = true
        passwordLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        passwordLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true
        passwordLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10).isActive = true
        passwordLabel.text = "Password"
        passwordLabel.textColor = .black
        
        self.view.addSubview(passwordField)
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 5).isActive = true
        passwordField.heightAnchor.constraint(equalToConstant: 44).isActive = true
        passwordField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true
        passwordField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10).isActive = true
        passwordField.layer.cornerRadius = 10
        passwordField.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)
        passwordField.isSecureTextEntry = true
        
        self.view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 50).isActive = true
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        button.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 50).isActive = true
        button.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -50).isActive = true
        button.layer.cornerRadius = 10
        button.setTitle("Sign In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 25/255, green: 142/255, blue: 255/255, alpha: 1.0)
        button.addTarget(self, action: #selector(signIn), for: .touchUpInside)
        
    }
    
    @objc func signIn()  {
        print("signin")
    }

}
