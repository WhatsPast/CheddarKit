//
//  SettingsVC.swift
//  CheddarKit
//
//  Created by Karl Weber on 5/27/19.
//  Copyright © 2019 Karl Weber. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {
    
    let accountLabel = UILabel()
    let logoutButton = UIButton()
    let divider = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutViews()
        giveViewsContext()
        view.backgroundColor = .whiteFive
        title = "Settings"
    }
    
    func layoutViews() {
        view.addSubview(accountLabel)
        view.addSubview(logoutButton)
        view.addSubview(divider)
        
        accountLabel.translatesAutoresizingMaskIntoConstraints = false; accountLabel.asCDKHeading()
        logoutButton.translatesAutoresizingMaskIntoConstraints = false; logoutButton.asCDKLinkButton()
        divider.translatesAutoresizingMaskIntoConstraints = false; divider.asCDKDivider()
        
        // lay them out
        accountLabel.marginLeft(10.0, to: view).marginTop(80.0, to: view).marginRight(-10.0, to: view)
        logoutButton.marginLeft(10.0, to: view).marginTop(80.0, to: view).marginRight(-10.0, to: view)
        divider.marginLeft(10.0, to: view).marginRight(-10.0, to: view)
        divider.topAnchor.constraint(equalTo: logoutButton.bottomAnchor, constant: 10.0).isActive = true
        
        
    }
    
    func giveViewsContext() {
        // Add text
        accountLabel.text = "Account"
        logoutButton.setTitle("Log Out", for: .normal)
        logoutButton.addTarget(self, action: #selector(logOut), for: .touchUpInside)
    }
    
    @objc func logOut() {
        print("Log Out")
        CheddarKit.sharedInstance.logout()
        (UIApplication.shared.delegate as! AppDelegate).loadLoginView()
    }
    
}
