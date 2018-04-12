//
//  CDKUser.swift
//  CheddarKit
//
//  Created by Karl Weber on 9/10/17.
//  Copyright © 2017 Karl Weber. All rights reserved.
//

import UIKit

// response objects
struct CDKAuthCode: Codable {
    let code: String
    let response: String
    let message: String
}
