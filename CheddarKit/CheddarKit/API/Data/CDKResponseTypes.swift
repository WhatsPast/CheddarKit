//
//  CDKResponseTypes.swift
//  CheddarKit
//
//  Created by Karl Weber on 9/10/17.
//  Copyright © 2017 Karl Weber. All rights reserved.
//

// for sure read these docs alot: https://developer.apple.com/documentation/foundation/archives_and_serialization/encoding_and_decoding_custom_types

import UIKit

// example: {"error":"invalid_client"}
struct CDKSimpleError: Codable {
    let error: String
}

// CDKToken
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
struct CDKToken: Codable {
    let access_token: String
    let token_type: String
    let user: CDKUser
}

struct CDKUser: Codable {
    let created_at: String
    let first_name: String?
    let has_plus: Bool
    let id: Int
    let last_name: String?
    let socket: CDKSocket
    let updated_at: String
    let url: String
    let username: String
}

struct CDKSocket: Codable {
    let api_key: String
    let app_id: String
    let auth_url: String
    let channel: String
}


// CDKLists
// This is the codable response when requesting all of a user's lists.
// Sample JSON:

//[
//    {
//        "active_completed_tasks_count": 0,
//        "active_tasks_count": 5,
//        "active_uncompleted_tasks_count": 5,
//        "archived_at": null,
//        "archived_completed_tasks_count": 15,
//        "archived_tasks_count": 15,
//        "archived_uncompleted_tasks_count": 0,
//        "created_at": "2017-08-12T07:50:00Z",
//        "id": 145701,
//        "invitation_count": 0,
//        "invitations": [],
//        "member_count": 1,
//        "position": 1,
//        "slug": "4E95",
//        "title": "Snap Auctions",
//        "updated_at": "2017-12-14T01:45:02Z",
//        "url": "https://api.cheddarapp.com/v1/lists/145701",
//        "user": {
//            "created_at": "2016-09-03T05:59:07Z",
//            "first_name": "Karl",
//            "has_plus": false,
//            "id": 67750,
//            "last_name": "Weber",
//            "socket": {
//                "api_key": "675f10a650f18b4eb0a8",
//                "app_id": "15197",
//                "auth_url": "https://api.cheddarapp.com/pusher/auth",
//                "channel": "private-user-67750"
//            },
//            "updated_at": "2017-01-18T15:53:40Z",
//            "url": "https://api.cheddarapp.com/v1/users/67750",
//            "username": "kow"
//        },
//        "users": [
//
//        ]
//    },
//    { … }
//]

typealias CDKLists = Array<CDKList>

struct CDKList: Codable {
    let active_completed_tasks_count: Int
    let active_tasks_count: Int
    let active_uncompleted_tasks_count: Int
    let archived_at: String?
    let archived_completed_tasks_count: Int
    let archived_tasks_count: Int
    let archived_uncompleted_tasks_count: Int
    let created_at: String
    let id: Int
    var invitation_count: Int
    var invitations: [String?]
    var member_count: Int
    var position: Int
    let slug: String
    var title: String
    let updated_at: String
    let url: String
    let user: CDKUser
    let users: [CDKUser]
}

typealias CDKTasks = Array<CDKTask>

struct CDKTask: Codable {
    let archived_at: String?
    let completed_at: String?
    let created_at: String
    let display_html: String?
    let display_text: String?
    let entities: [CDKEntity]
}

struct CDKEntity: Codable {
    // TODO: Make this a true enum
    let type: String // Making this a true enum would be a lot of work see here: https://stackoverflow.com/questions/47139768/swift-codable-protocol-with-recursive-enums
    let text: String
    let indices: [Int]
    let display_text: String
    let display_indices: [Int]
}

struct CDKTag: Codable {
    let id: Int
    let name: String
}

enum CDKEntityType: CustomStringConvertible {
    case tag
    case link
    case emphasis
    case double_emphasis
    case triple_emphasis
    case strikethrough
    case code
    case emoji
    
    var description: String {
        switch self {
        case .tag:
            return "tag"
        case .link:
            return "link"
        case .emphasis:
            return "emphasis"
        case .double_emphasis:
            return "double_emphasis"
        case .triple_emphasis:
            return "triple_emphasis"
        case .strikethrough:
            return "strikethrough"
        case .code:
            return "code"
        case .emoji:
            return "emoji"
        default:
            return "emphasis"
        }
    }
    
    func from(string: String) -> CDKEntityType {
        switch string {
        case "tag":
            return .tag
        case "link":
            return .link
        case "emphasis":
            return .emphasis
        case "double_emphasis":
            return .double_emphasis
        case "triple_emphasis":
            return .triple_emphasis
        case "strikethrough":
            return .strikethrough
        case "code":
            return .code
        case "emoji":
            return .emoji
        default:
            return .emphasis
        }
    }
}






