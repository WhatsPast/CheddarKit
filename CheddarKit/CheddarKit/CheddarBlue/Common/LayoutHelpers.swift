//
//  LayoutHelpers.swift
//  CheddarKit
//
//  Created by Karl Weber on 5/27/19.
//  Copyright © 2019 Karl Weber. All rights reserved.
//

import UIKit

extension UIView {
    
    @discardableResult func marginTop(_ marginTop: CGFloat, to superview: UIView) -> UIView {
        topAnchor.constraint(equalTo: superview.topAnchor, constant: marginTop).isActive = true
        return self
    }
    
    @discardableResult func marginBottm(_ marginBottm: CGFloat, to superview: UIView) -> UIView {
        bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: marginBottm).isActive = true
        return self
    }
    
    @discardableResult func marginLeft(_ marginLeft: CGFloat, to superview: UIView) -> UIView {
        leftAnchor.constraint(equalTo: superview.leftAnchor, constant: marginLeft).isActive = true
        return self
    }
    
    @discardableResult func marginRight(_ marginRight: CGFloat, to superview: UIView) -> UIView {
        rightAnchor.constraint(equalTo: superview.rightAnchor, constant: marginRight).isActive = true
        return self
    }
    
    
    
    
}
