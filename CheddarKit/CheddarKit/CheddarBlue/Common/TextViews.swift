//
//  TextViews.swift
//  CheddarKit
//
//  Created by Karl Weber on 5/27/19.
//  Copyright © 2019 Karl Weber. All rights reserved.
//

import UIKit

// TextViews literally contains a small set of custom reusable views for laying out text
// and headers in a predictable manner. It's for non application type pages. Settings pages,
// tutorial pages, reading, etc...

// a simple heading view
extension UILabel {
    func asCDKHeading() {
        font = UIFont.systemFont(ofSize: 32.0, weight: UIFont.Weight.bold)
        textColor = .blackOne
        heightAnchor.constraint(equalToConstant: 32.0).isActive = true
    }
}

// Horizontal Rule, like a divider
extension UIView { // CDKDivider
    func asCDKDivider() {
        backgroundColor = .blackFive
        heightAnchor.constraint(equalToConstant: 3.0).isActive = true
        layer.cornerRadius = 1.5
    }
}

// Blue Link Button
extension UIButton {
    func asCDKLinkButton() {
        titleLabel?.font = UIFont.systemFont(ofSize: 16.0, weight: UIFont.Weight.medium)
        contentHorizontalAlignment = .right
        setTitleColor(.blueOne, for: .normal)
        heightAnchor.constraint(equalToConstant: 32.0).isActive = true
    }
}
