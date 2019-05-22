//
//  Colors.swift
//  CheddarKit
//
//  Created by Karl Weber on 4/5/18.
//  Copyright © 2018 Karl Weber. All rights reserved.
//

import UIKit

extension UIColor {
    
    // Blacks, from Dark to light.
    static var blackOne: UIColor { return UIColor.RGBToColor(56, 56, 56, 1.0) }
    static var blackTwo: UIColor { return UIColor.RGBToColor(73, 73, 73, 1.0) }
    static var blackThree: UIColor { return UIColor.RGBToColor(103, 103, 103, 1.0) }
    static var blackFour: UIColor { return UIColor.RGBToColor(150, 150, 150, 1.0) }
    static var blackFive: UIColor { return UIColor.RGBToColor(185, 185, 185, 1.0) }
    static var blackSix: UIColor { return UIColor.RGBToColor(200, 200, 200, 1.0) }
    static var blackSeven: UIColor { return UIColor.RGBToColor(228, 228, 228, 1.0) }
    
    // Whites, from light to dar.
    static var whiteOne: UIColor { return UIColor.RGBToColor(255, 255, 255, 1.0) }
    static var whiteTwo: UIColor { return UIColor.RGBToColor(249, 249, 249, 1.0) }
    static var whiteThree: UIColor { return UIColor.RGBToColor(246, 246, 246, 1.0) }
    static var whiteFour: UIColor { return UIColor.RGBToColor(243, 243, 243, 1.0) }
    static var whiteFive: UIColor { return UIColor.RGBToColor(239, 239, 239, 1.0) }
    static var whiteSix: UIColor { return UIColor.RGBToColor(235, 235, 235, 1.0) }
    static var whiteSeven: UIColor { return UIColor.RGBToColor(228, 228, 228, 1.0) }
    
    // Oranges
    static var orangeOne: UIColor { return UIColor.RGBToColor(255, 114, 58, 1.0) }
    
    // Blues
    static var blueOne: UIColor { return UIColor.RGBToColor(25, 142, 255, 1.0) }

    // The background Color for the application
    static var appBackgroundColor: UIColor { return UIColor.whiteFive }
    
    class func RGBToColor(_ red: Float, _ green: Float, _ blue: Float, _ alpha: Float) -> UIColor {
        return UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: CGFloat(alpha))
    }
    
}
