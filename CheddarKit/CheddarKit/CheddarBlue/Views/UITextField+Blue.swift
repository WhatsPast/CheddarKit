//
//  UITextField+Blue.swift
//  CheddarKit
//
//  Created by Karl Weber on 9/9/17.
//  Copyright © 2017 Karl Weber. All rights reserved.
//

import UIKit
import QuartzCore

class TextField: UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10);
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func drawPlaceholder(in rect: CGRect) {
//        UIColor.blackFour.setFill()
        let new_rect = CGRect(x: rect.origin.x, y: rect.origin.y + 4.0, width: rect.size.width, height: rect.size.height)
        NSString(string: placeholder ?? "").draw(in: new_rect, withAttributes:
            [.font: UIFont.systemFont(ofSize: 18.0, weight: UIFont.Weight.regular),
             .foregroundColor: UIColor.blackFour])
    }

}

extension UITextField {
    
    func activeState() {
        self.showShadow()
        self.addBorder()
    }
    
    func inactiveState() {
        self.hideShadow()
        self.hideBorder()
    }
    
    func hideBorder() {
        self.layer.borderWidth = 2.0
        self.layer.borderColor = UIColor.orangeOne.cgColor
        let borderAnimation = CABasicAnimation(keyPath: "borderWidth")
        borderAnimation.fillMode = CAMediaTimingFillMode.forwards
        borderAnimation.isRemovedOnCompletion = false
        borderAnimation.fromValue = 2.0
        borderAnimation.toValue = 0.0
        borderAnimation.duration = 0.23
        
        let animator = UIViewPropertyAnimator(duration: 0.23, dampingRatio: 95, animations: {
            self.layer.add(borderAnimation, forKey: "borderWidth")
        })
        animator.startAnimation()
    }
    
    func addBorder() {
        self.layer.borderWidth = 0.0
        self.layer.borderColor = UIColor.orangeOne.cgColor
        let borderAnimation = CABasicAnimation(keyPath: "borderWidth")
        borderAnimation.fillMode = CAMediaTimingFillMode.forwards
        borderAnimation.isRemovedOnCompletion = false
        borderAnimation.fromValue = 0.0
        borderAnimation.toValue = 2.0
        borderAnimation.duration = 0.23
        
        let animator = UIViewPropertyAnimator(duration: 0.23, dampingRatio: 95, animations: {
            self.layer.add(borderAnimation, forKey: "borderWidth")
        })
        animator.startAnimation()
    }
    
    // add orange Shadow
    func showShadow() {
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.orangeOne.cgColor
        self.layer.shadowOpacity = 0.0
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 10
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        
        
        let shadowAnimation = CABasicAnimation(keyPath: "shadowOpacity")
        shadowAnimation.fillMode = CAMediaTimingFillMode.forwards
        shadowAnimation.isRemovedOnCompletion = false
        shadowAnimation.fromValue = 0.0
        shadowAnimation.toValue = 0.5
        shadowAnimation.duration = 0.23
        
        let animator = UIViewPropertyAnimator(duration: 0.23, dampingRatio: 95, animations: {
            self.layer.add(shadowAnimation, forKey: "shadowOpacity")
        })
        animator.startAnimation()
    }
    
    // remove orange shadow
    func hideShadow() {
        self.layer.shadowColor = UIColor.orangeOne.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 10
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        
        let shadowAnimation = CABasicAnimation(keyPath: "shadowOpacity")
        shadowAnimation.fillMode = CAMediaTimingFillMode.forwards
        shadowAnimation.isRemovedOnCompletion = false
        shadowAnimation.fromValue = 0.5
        shadowAnimation.toValue = 0.0
        shadowAnimation.duration = 0.23
        
        let animator = UIViewPropertyAnimator(duration: 0.23, dampingRatio: 95, animations: {
            self.layer.add(shadowAnimation, forKey: "shadowOpacity")
        })
        animator.startAnimation()
    }
    
}
