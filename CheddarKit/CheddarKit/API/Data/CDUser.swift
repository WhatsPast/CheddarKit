//
//  CDUser.swift
//  CheddarKit
//
//  Created by Karl Weber on 9/10/17.
//  Copyright © 2017 Karl Weber. All rights reserved.
//

import UIKit


// AuthorizeUser
struct CDAuthorizeUser: Codable {
//    let username: String
//    let password: String
    let clientID: String
    let redirectURI: String
    let state: String
}

// Login User
struct CDLoginUser: Codable {
    let username: String
    let password: String
}


// response objects
struct CDAuthCode: Codable {
    let code: String
    let response: String
    let message: String
}



