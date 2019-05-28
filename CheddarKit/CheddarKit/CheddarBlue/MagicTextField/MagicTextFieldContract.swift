//
//  MagicTextFieldContract.swift
//  CheddarKit
//
//  Created by Karl Weber on 5/21/19.
//  Copyright © 2019 Karl Weber. All rights reserved.
//

import UIKit

/*
    MagicTextField is a ViewController meant to be presented over
    another view controller partiall obscuring it's view.
    It can also be pushed onto a UINavigationController Stack.
*/
protocol MagicTextField: UIViewController {
    // For clearing the text.
    func clearText()
    // Loads some text into the field.
    func loadText(_ text: String)
    // grow expands the textField to fill the screen.
    func grow()
    // shrink collapses the text field to float at the bottom of whatever View It's the child of.
    func shrink()
}

/*
    The MagicTextField sends the delegate messages about stuff.
 */
protocol MagicTextFieldDelegate {
    // When the magic text field is dismissed
    func didDismissMagicText()
    // When the user taps the cancel
    func didCancelMagicText()
    // When the text field saves their current state
    func didSaveMagicText(withText: String)
}
