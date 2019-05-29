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
    
    let logoView = UIImageView(image: UIImage(named: "CheddarLogo"))
    let usernameLabel = UILabel()
    let usernameField = TextField()
    let passwordLabel = UILabel()
    let passwordField = TextField()
    let signUpLinkButton = UIButton()
    let resetLinkButton = UIButton()
    let haveAccountLinkButton = UIButton()
    let button = UIButton()
    
    // signup only UI
    let emailLabel = UILabel()
    let emailField = TextField()
    let signUpButton = UIButton()
    
    // forgot only UI
    let resetButton = UIButton()
    
    // LoginLinkButton
    let LoginLinkButton = UIButton()
    
    
    // UIState
    var UIState: String = "login" // login, signup, forgot
    var isAnimating = false
    
    // animation Constraints
    var usernameLabelTopConstraintLogin: NSLayoutConstraint?
    var usernameLabelTopConstraintSignup: NSLayoutConstraint?
    var loginLinkTopConstraintSignup: NSLayoutConstraint?
    var loginLinkTopConstraintForgot: NSLayoutConstraint?
    
    func setupViews() {
        
        view.backgroundColor = .appBackgroundColor
        
        
        // add subviews
        view.addSubview(logoView)
        view.addSubview(usernameLabel)
        view.addSubview(usernameField)
        view.addSubview(passwordLabel)
        view.addSubview(passwordField)
        view.addSubview(signUpLinkButton)
        view.addSubview(resetLinkButton)
        view.addSubview(button)
        view.addSubview(emailLabel)
        view.addSubview(emailField)
        view.addSubview(signUpButton)
        view.addSubview(LoginLinkButton)
        view.addSubview(resetButton)
        
        logoView.translatesAutoresizingMaskIntoConstraints = false
        logoView.topAnchor.constraint(equalTo: view.topAnchor, constant: 48).isActive = true
        logoView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoView.heightAnchor.constraint(equalToConstant: 31).isActive = true
        logoView.widthAnchor.constraint(equalToConstant: 188).isActive = true
        
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        usernameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 17).isActive = true
        usernameLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        usernameLabel.text = "Username"
        usernameLabel.font = UIFont.systemFont(ofSize: 12)
        usernameLabel.textColor = .blackTwo
        // changing constraints
        usernameLabelTopConstraintLogin = usernameLabel.topAnchor.constraint(equalTo: logoView.bottomAnchor, constant: 20)
        usernameLabelTopConstraintLogin!.isActive = true
        
        usernameField.translatesAutoresizingMaskIntoConstraints = false
        usernameField.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 0).isActive = true
        usernameField.heightAnchor.constraint(equalToConstant: 32).isActive = true
        usernameField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        usernameField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        usernameField.layer.cornerRadius = 10
        usernameField.backgroundColor = .whiteTwo
        usernameField.delegate = loginDelegate
        usernameField.placeholder = "Username"
        usernameField.autocorrectionType = .no
        usernameField.autocapitalizationType = .none
        usernameField.spellCheckingType = .no
        
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordLabel.topAnchor.constraint(equalTo: usernameField.bottomAnchor, constant: 10).isActive = true
        passwordLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        passwordLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 17).isActive = true
        passwordLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        passwordLabel.text = "Password"
        passwordLabel.font = UIFont.systemFont(ofSize: 12)
        passwordLabel.textColor = .blackTwo
        
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 0).isActive = true
        passwordField.heightAnchor.constraint(equalToConstant: 32).isActive = true
        passwordField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        passwordField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        passwordField.layer.cornerRadius = 10
        passwordField.backgroundColor = .whiteTwo
        passwordField.isSecureTextEntry = true
        passwordField.delegate = loginDelegate
        passwordField.placeholder = "Password"
        
        // Add little don't have a username or account buttons.
        signUpLinkButton.asSmallCDKLinkButton()
        signUpLinkButton.translatesAutoresizingMaskIntoConstraints = false
        signUpLinkButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 15).isActive = true
        signUpLinkButton.widthAnchor.constraint(equalToConstant: 300.0).isActive = true
        signUpLinkButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signUpLinkButton.setTitle("Don't have an account? Sign up.", for: .normal)
        signUpLinkButton.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        
        resetLinkButton.asSmallCDKLinkButton()
        resetLinkButton.translatesAutoresizingMaskIntoConstraints = false
        resetLinkButton.topAnchor.constraint(equalTo: signUpLinkButton.bottomAnchor, constant: 0).isActive = true
        resetLinkButton.widthAnchor.constraint(equalToConstant: 300.0).isActive = true
        resetLinkButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        resetLinkButton.setTitle("Need help? Reset your password.", for: .normal)
        resetLinkButton.addTarget(self, action: #selector(forgot), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.topAnchor.constraint(equalTo: resetLinkButton.bottomAnchor, constant: 20).isActive = true
        button.heightAnchor.constraint(equalToConstant: 32).isActive = true
        button.widthAnchor.constraint(equalToConstant: 120.0).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.layer.cornerRadius = 10
        button.setTitle("Sign In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blueOne
        button.addTarget(self, action: #selector(signIn), for: .touchUpInside)
        
        // set up email stuff
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.topAnchor.constraint(equalTo: logoView.bottomAnchor, constant: 20).isActive = true
        emailLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 17).isActive = true
        emailLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        emailLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        emailLabel.text = "Email"
        emailLabel.font = UIFont.systemFont(ofSize: 12)
        emailLabel.textColor = .blackTwo
        
        emailField.translatesAutoresizingMaskIntoConstraints = false
        emailField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 0).isActive = true
        emailField.heightAnchor.constraint(equalToConstant: 32).isActive = true
        emailField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        emailField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        emailField.layer.cornerRadius = 10
        emailField.backgroundColor = .whiteTwo
        emailField.delegate = loginDelegate
        emailField.placeholder = "Email"
        emailField.autocorrectionType = .no
        emailField.autocapitalizationType = .none
        emailField.spellCheckingType = .no
        emailField.keyboardType = .emailAddress
        
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.topAnchor.constraint(equalTo: LoginLinkButton.bottomAnchor, constant: 20).isActive = true
        signUpButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
        signUpButton.widthAnchor.constraint(equalToConstant: 120.0).isActive = true
        signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signUpButton.layer.cornerRadius = 10
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.setTitleColor(.white, for: .normal)
        signUpButton.backgroundColor = .blueOne
        signUpButton.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        
        // setup LoginLinkButton
        LoginLinkButton.asSmallCDKLinkButton()
        LoginLinkButton.translatesAutoresizingMaskIntoConstraints = false
        LoginLinkButton.widthAnchor.constraint(equalToConstant: 300.0).isActive = true
        LoginLinkButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        LoginLinkButton.setTitle("Already have an account? Sign In.", for: .normal)
        LoginLinkButton.addTarget(self, action: #selector(changeToLoginState), for: .touchUpInside)
        loginLinkTopConstraintSignup = LoginLinkButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 15)
        loginLinkTopConstraintSignup?.isActive = true
        
        // setup reset button
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.topAnchor.constraint(equalTo: LoginLinkButton.bottomAnchor, constant: 20).isActive = true
        resetButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
        resetButton.widthAnchor.constraint(equalToConstant: 120.0).isActive = true
        resetButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        resetButton.layer.cornerRadius = 10
        resetButton.setTitle("Reset", for: .normal)
        resetButton.setTitleColor(.white, for: .normal)
        resetButton.backgroundColor = .blueOne
//        resetButton.addTarget(self, action: #selector(forgot), for: .touchUpInside)
        
        emailLabel.isHidden = true
        emailField.isHidden = true
        signUpButton.isHidden = true
        LoginLinkButton.isHidden = true
        resetButton.isHidden = true
        emailLabel.layer.opacity = 0.0
        emailField.layer.opacity = 0.0
        signUpButton.layer.opacity = 0.0
        LoginLinkButton.layer.opacity = 0.0
        resetButton.layer.opacity = 0.0
        
        // signup constraints
        usernameLabelTopConstraintSignup = usernameLabel.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 10)
        
        // forgot & signup Constraints
        loginLinkTopConstraintForgot = LoginLinkButton.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 15)
    }
    
    @objc func signIn()  {
        print("Sign In")
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
    
    @objc func signUp() {
        print("Sign Up")
        if isAnimating == false {
            isAnimating = true
            changeToSignUpState()
        }
    }
    
    @objc func forgot() {
        print("forgot")
        if isAnimating == false {
            isAnimating = true
            changeToForgotState()
        }
    }

}


// State animations and mutations
extension LoginViewController {
    
    @objc func changeToLoginState() {
        UIView.animate(withDuration: 0.30, delay:0.0, options:UIView.AnimationOptions(), animations: {
            
            // stuff to hide
            self.emailLabel.layer.opacity = 0.0
            self.emailField.layer.opacity = 0.0
            self.signUpButton.layer.opacity = 0.0
            self.resetButton.layer.opacity = 0.0
            self.LoginLinkButton.layer.opacity = 0.0
            
            // stuff to show
            self.button.isHidden = false
            self.signUpLinkButton.isHidden = false
            self.resetLinkButton.isHidden = false
            self.usernameLabel.isHidden = false
            self.usernameField.isHidden = false
            self.passwordLabel.isHidden = false
            self.passwordField.isHidden = false
            
            self.button.layer.opacity = 1.0
            self.usernameLabel.layer.opacity = 1.0
            self.usernameField.layer.opacity = 1.0
            self.passwordLabel.layer.opacity = 1.0
            self.passwordField.layer.opacity = 1.0
            self.signUpLinkButton.layer.opacity = 1.0
            self.resetLinkButton.layer.opacity = 1.0
            
            self.loginLinkTopConstraintSignup?.isActive = true
            self.loginLinkTopConstraintForgot?.isActive = false
            self.usernameLabelTopConstraintLogin?.isActive = true
            self.usernameLabelTopConstraintSignup?.isActive = false
            self.view.layoutIfNeeded() // we need to call this to change the constraints
            
        }, completion: { (isTrue: Bool) in
            self.emailLabel.isHidden = true
            self.emailField.isHidden = true
            self.signUpButton.isHidden = true
            self.resetButton.isHidden = true
            self.LoginLinkButton.isHidden = true
            self.isAnimating = false
        })
    }
    
    @objc func changeToSignUpState() {
        UIView.animate(withDuration: 0.30, delay:0.0, options:UIView.AnimationOptions(), animations: {

            // stuff to hide
            self.button.layer.opacity = 0.0
            self.signUpLinkButton.layer.opacity = 0.0
            self.resetLinkButton.layer.opacity = 0.0
            
            // stuff to show
            self.emailLabel.layer.opacity = 1.0
            self.emailField.layer.opacity = 1.0
            self.signUpButton.layer.opacity = 1.0
            self.LoginLinkButton.layer.opacity = 1.0
            self.emailLabel.isHidden = false
            self.emailField.isHidden = false
            self.signUpButton.isHidden = false
            self.LoginLinkButton.isHidden = false
            self.usernameLabelTopConstraintLogin?.isActive = false
            self.usernameLabelTopConstraintSignup?.isActive = true
            self.loginLinkTopConstraintSignup?.isActive = true
            self.loginLinkTopConstraintForgot?.isActive = false
            self.view.layoutIfNeeded() // we need to call this to change the constraints

        }, completion: { (isTrue: Bool) in
            self.button.isHidden = true
            self.signUpLinkButton.isHidden = true
            self.resetLinkButton.isHidden = true
            self.isAnimating = false
        })
    }
    
    @objc func changeToForgotState() {
        UIView.animate(withDuration: 0.30, delay:0.0, options:UIView.AnimationOptions(), animations: {
            
            // stuff to hide
            self.button.layer.opacity = 0.0
            self.usernameLabel.layer.opacity = 0.0
            self.usernameField.layer.opacity = 0.0
            self.passwordLabel.layer.opacity = 0.0
            self.passwordField.layer.opacity = 0.0
            self.signUpLinkButton.layer.opacity = 0.0
            self.resetLinkButton.layer.opacity = 0.0
            
            // stuff to show
            self.emailLabel.isHidden = false
            self.emailField.isHidden = false
            self.signUpButton.isHidden = false
            self.resetButton.isHidden = false
            self.LoginLinkButton.isHidden = false
            self.emailLabel.layer.opacity = 1.0
            self.emailField.layer.opacity = 1.0
            self.signUpButton.layer.opacity = 1.0
            self.resetButton.layer.opacity = 1.0
            self.LoginLinkButton.layer.opacity = 1.0

            self.loginLinkTopConstraintSignup?.isActive = false
            self.loginLinkTopConstraintForgot?.isActive = true
            self.view.layoutIfNeeded() // we need to call this to change the constraints
            
        }, completion: { (isTrue: Bool) in
            self.button.isHidden = true
            self.signUpLinkButton.isHidden = true
            self.resetLinkButton.isHidden = true
            self.usernameLabel.isHidden = true
            self.usernameField.isHidden = true
            self.passwordLabel.isHidden = true
            self.passwordField.isHidden = true
            self.isAnimating = false
        })
        
    }
    
}
