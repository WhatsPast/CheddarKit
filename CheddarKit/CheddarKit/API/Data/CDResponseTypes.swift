//
//  CDResponseTypes.swift
//  CheddarKit
//
//  Created by Karl Weber on 9/10/17.
//  Copyright © 2017 Karl Weber. All rights reserved.
//

// for sure read these docs alot: https://developer.apple.com/documentation/foundation/archives_and_serialization/encoding_and_decoding_custom_types

import UIKit

// example: {"error":"invalid_client"}
struct CDSimpleError: Codable {
    let error: String
}

// CDTokenResponse
// This is the codable response that is returned when turning an authorization code
// into an authorization Token. Sample JSON is shown below.

//{
//    "access_token": "40ab292399e963062dc26645a4f7e714",
//    "token_type": "bearer",
//    "user": {
//        "created_at": "2016-09-03T05:59:07Z",
//        "first_name": "Karl",
//        "has_plus": false,
//        "id": 67750,
//        "last_name": "Weber",
//        "socket": {
//            "api_key": "675f10a650f18b4eb0a8",
//            "app_id": "15197",
//            "auth_url": "https://api.cheddarapp.com/pusher/auth",
//            "channel": "private-user-67750"
//        },
//        "updated_at": "2017-01-18T15:53:40Z",
//        "url": "https://api.cheddarapp.com/v1/users/67750",
//        "username": "kow"
//    }
//}
struct CDTokenResponse: Codable {
    let access_token: String
    let token_type: String
    let user: CDUser
}

struct CDUser: Codable {
    let created_at: String
    let first_name: String?
    let has_plus: Bool
    let id: Int
    let last_name: String?
    let socket: CDSocket
    let updated_at: String
    let url: String
    let username: String
}

struct CDSocket: Codable {
    let api_key: String
    let app_id: String
    let auth_url: String
    let channel: String
}

