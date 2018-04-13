//
//  CheckButtonViewController.swift
//  CheddarKit
//
//  Created by Karl Weber on 4/11/18.
//  Copyright © 2018 Karl Weber. All rights reserved.
//

/*
    CheckButtonViewController is a custom UIButton that highly animates a custom little
 checkbox. It requires a View Controller because the interaction is so complicated and
 custom that we need a custom tapGesturRecognizer to figure out what state the Views
 should be in.
 */

import UIKit

protocol CheckButtonProtocol {
    
    // Used to configure the Button for reuse in a cell
    func configure(withIndex index: NSIndexPath?, andDelegate buttonDelegate: CheckButtonDelegateProtocol?)

    // Checks or unChecks the button programmatically
    func check(animated: Bool)
    func uncheck(animated: Bool)
    
    // sets the state to complete or incomplete.
    func setState(complete: Bool, animated: Bool)

}

public protocol CheckButtonDelegateProtocol {
    
    func buttonWasChecked(for indexPath: NSIndexPath?) -> ()
    func buttonWasUnChecked(for indexPath: NSIndexPath?) -> ()
    
}

class CheckButtonViewController: UIViewController {
    
    var delegate: CheckButtonDelegateProtocol?
    var longPress = UILongPressGestureRecognizer()
    var indexPath: NSIndexPath?
    var state: buttonState = .incomplete
    var isChecked: Bool {
        get {
            if state == .incomplete { return false }
            return true
        }
        set {
            if newValue == true {
                state = .complete
//                self.check(animated: true)
            } else {
                state = .incomplete
//                self.uncheck(animated: false)
            }
        }
    }
    
    enum buttonState {
        case complete
        case incomplete
    }
    
    // actual Views
//    let uncheckedView = UIImageView(image: UIImage(named: "uncheckedBox"))
//    let checkedView = UIImageView(image: UIImage(named: "checkedBox"))
    let uncheckedView = UIImageView(image: UIImage(named: "uncheckedBox36"))
    let checkedView = UIImageView(image: UIImage(named: "checkedBox36"))
    
    convenience init(withIndex index: NSIndexPath?, andDelegate buttonDelegate: CheckButtonDelegateProtocol?) {
        self.init(nibName: nil, bundle: nil)
        self.configure(withIndex:index, andDelegate: buttonDelegate)
    }
    
    override func viewDidLoad() {
        // load that view!!!
        setupViews()
        setupGestureRecognizer()
    }
    
    // Setup functions
    func setupViews() {
        
        // add Checked View
        checkedView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(checkedView)
        checkedView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0.0).isActive = true
        checkedView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0.0).isActive = true
        checkedView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.0).isActive = true
        checkedView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.0).isActive = true
        checkedView.layer.opacity = 0.0
        
        // add UnChecked View
        uncheckedView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(uncheckedView)
        uncheckedView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0.0).isActive = true
        uncheckedView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0.0).isActive = true
        uncheckedView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.0).isActive = true
        uncheckedView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.0).isActive = true
    }
    
    func setupGestureRecognizer() {
        longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressGestureRecognized))
        longPress.minimumPressDuration = 0.0
        self.view.addGestureRecognizer(longPress)
    }
    
}

// gestureRecognizerStuff
extension CheckButtonViewController {
    
    @objc func longPressGestureRecognized(sender:UILongPressGestureRecognizer) {
        
        let lp = sender as UILongPressGestureRecognizer
        let state = lp.state
        let location = longPress.location(in: self.view)
        
        switch state {
        case .began:
            // Active the touch Down State whatever it should be.
            if isChecked {
                transformToCheckedDown(animated: true)
            } else {
                transformToUnCheckedDown(animated: true)
            }
            
            break
        case .changed:
            
            if isFingerInBounds(location) {
                if isChecked {
                    transformToCheckedDown(animated: true)
                } else {
                    transformToUnCheckedDown(animated: true)
                }
            } else {
                if isChecked {
                    transformToCheckedUp(animated: true)
                } else {
                    transformToUnCheckedUp(animated: true)
                }
            }
            
            break
        
        case .ended:
            
            if isFingerInBounds(location) {
                // we switch the opacity of the objects and change what's checked.
                if isChecked {
                    // transform to uncheckedUp and uncheck it
                    setState(complete: false, animated: true)
                } else {
                    // transform to Checked Up and check it.
                    setState(complete: true, animated: true)
                }
            } else {
                // we essentially do nothing because we don't need to.
                if isChecked {
                    transformToCheckedUp(animated: true)
                } else {
                    transformToUnCheckedUp(animated: true)
                }
            }
            
            break
        default:
            // Clean up
            if isChecked {
                transformToCheckedUp(animated: true)
            } else {
                transformToUnCheckedUp(animated: true)
            }
            break
        }
    }
    
    // utilitiy functions
    func isFingerInBounds(_ location: CGPoint) -> Bool {
        if location.x < 0
            || location.x > self.view.frame.width
            || location.y < 0
            || location.y > self.view.frame.height {
            // out of bounds
            return false
        } else {
            // in bounds
            return true
        }
    }
    
}

// MARK: animation functions
extension CheckButtonViewController {
    
    /*
        The animation process moves the button between the checked and unchecked states.
     uncheckedDown animates when the user taps on on incomplete checkbox. If the user
     touchesUpInside the button then it moves to the other state: checkedUp; If ther user
     touchesUpOutside the button then it's state doesn't change and the uncheckedUp animation
     is called, signalling that nothing has really changed. The reverse is true if the
     */
    
    // Transform to uncheckedDown
    func transformToUnCheckedDown(animated: Bool) {
        UIView.animate(withDuration: 0.19, delay: 0, options: .curveEaseOut, animations: {
            self.uncheckedView.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        }, completion: nil)
    }
    
    // Transform to uncheckedUp
    func transformToUnCheckedUp(animated: Bool) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.uncheckedView.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    
    // Transform to checkedDown
    func transformToCheckedDown(animated: Bool) {
        UIView.animate(withDuration: 0.19, delay: 0, options: .curveEaseOut, animations: {
            self.checkedView.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        }, completion: nil)
    }
    
    // Transform to checkedUp
    func transformToCheckedUp(animated: Bool) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.checkedView.transform = CGAffineTransform.identity
        }, completion: nil)
    }
}

// MARK: Feedback/callback functions
extension CheckButtonViewController: CheckButtonProtocol {
    
    // Configures the CheckButtonViewController for reuse.
    func configure(withIndex index: NSIndexPath?, andDelegate buttonDelegate: CheckButtonDelegateProtocol?) {
        if index != nil { indexPath = index! }
        if buttonDelegate != nil { delegate = buttonDelegate! }
    }
    
    func setState(complete: Bool, animated: Bool) {
        state = .incomplete
        if complete { state = .complete }

        if complete {
            uncheckedView.layer.opacity = 0.0
            checkedView.layer.opacity = 1.0
            checkedView.transform = CGAffineTransform(scaleX: 0.25, y: 0.25)
            transformToCheckedUp(animated: true)
            isChecked = true
            delegate?.buttonWasChecked(for: indexPath)
        } else {
            checkedView.layer.opacity = 0.0
            uncheckedView.layer.opacity = 1.0
            uncheckedView.transform = CGAffineTransform(scaleX: 0.25, y: 0.25)
            transformToUnCheckedUp(animated: true)
            isChecked = false
            delegate?.buttonWasUnChecked(for: indexPath)
        }
    }
    
    func check(animated: Bool) {
        DispatchQueue.main.async {
            self.setState(complete: true, animated: animated)
        }
    }
    
    func uncheck(animated: Bool) {
        DispatchQueue.main.async {
            self.setState(complete: false, animated: animated)
        }
    }
}












