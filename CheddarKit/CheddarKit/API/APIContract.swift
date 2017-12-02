//
//  APIContract.swift
//  CheddarKit
//
//  Created by Karl Weber on 9/11/17.
//  Copyright © 2017 Karl Weber. All rights reserved.
//

import UIKit

protocol CDAPIManagerProtocol {

}

// Authentication
protocol CDAuthenticationProtocol {
    
    // generate an authorizeUser URLRequest for a webview to consume.
    func authorizeUser() -> URLRequest
    // Convert an Authorization code into an Auth Token.
    func convertCodeToToken(code: String, callback: (_ token: CDTokenResponse?, _ error: CDSimpleError?) -> ()?)
}

// Users
protocol CDUsersProtocol {
    // show an authenticated user
    func user() // broadcasts .didGetUser2
    // show a user's invitations
}

protocol CDListsProtocol {
    // Lists
        // show all lists
        // show a list
        // update a list
        // create a list
        // reorder lists
        // share a list
        // show a list's members
        // remove member's from a list
        // delete an invitation
        // accept an invitation
}
    
    // Tasks
        // show all tasks in a List
        // show a task
        // update a task
        // create a task
        // move a task to a new list
        // reorder tasks in a list
        // archive all tasks in a list
        // archive completed tasks in a list
    
    // Entities
    
    // Realtime Events
        // List Events
            // list created
            // list updated
            // lists reordered
            // invitation accepted
            // member removed from a list
        // Task Events
            // task created
            // task updated
            // tasks reordered
        // User Events
            // User updated

    

