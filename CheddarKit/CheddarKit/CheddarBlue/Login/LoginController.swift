//
//  LoginController.swift
//  CheddarKit
//
//  Created by Karl Weber on 9/10/17.
//  Copyright © 2017 Karl Weber. All rights reserved.
//

import UIKit

class LoginController: NSObject, CDWebViewDelegate {
    
    func cheddarAuthResponse(codeResponse: CDAuthCode) {
        if codeResponse.response == "success" {
            // it worked
            // parse that
            
        } else {
            
//            post errors
        }
    }
}
