//
//  NavigationController.swift
//  CheddarKit
//
//  Created by Karl Weber on 5/27/19.
//  Copyright © 2019 Karl Weber. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    
    // Settings button accessory View
    let settingsButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSettingsView()
        navigationBar.backgroundColor = .whiteFive
    }
    
    func setupSettingsView() {
        
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        navigationBar.addSubview(settingsButton)
        settingsButton.setImage(UIImage(named: "GearIcon"), for: .normal)
        settingsButton.widthAnchor.constraint(equalToConstant: 32.0).isActive = true
        settingsButton.heightAnchor.constraint(equalToConstant: 32.0).isActive = true
        settingsButton.rightAnchor.constraint(equalTo: navigationBar.rightAnchor, constant: -7.0).isActive = true
        settingsButton.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: -7.0).isActive = true
        settingsButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        settingsButton.contentHorizontalAlignment = .fill
        settingsButton.contentVerticalAlignment = .fill
        let bbi = UIBarButtonItem(customView: settingsButton)
        self.navigationItem.setRightBarButton(bbi, animated: false)

        settingsButton.addTarget(self, action: #selector(openSettingsView), for: .touchUpInside)
    }
    
    var isOpeningSettings = false
    @objc func openSettingsView() {
        print("load it up now.")
        if isOpeningSettings == false {
            isOpeningSettings = true
            self.pushViewController(SettingsVC(), animated: true)
        }
    }
    
    override func popViewController(animated: Bool) -> UIViewController? {
        let vcToPop = viewControllers.last
        super.popViewController(animated: animated)
        if vcToPop?.title == "Settings" {
            isOpeningSettings = false
            print("It's the settings page.")
        } else {
            print("It It's not the settings page.")
        }
        return vcToPop
    }
}
