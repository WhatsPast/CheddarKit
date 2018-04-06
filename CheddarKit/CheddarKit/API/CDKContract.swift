//
//  CDKContract.swift
//  CheddarKit
//
//  Created by Karl Weber on 9/11/17.
//  Copyright © 2017 Karl Weber. All rights reserved.
//

import UIKit

protocol CDKAPIManagerProtocol {

}

// Constants
let CDKSessionKey = "cheddarkit-serialized-usersession"

// Authentication
protocol CDKAuthenticationProtocol {
    // generate an authorizeUser URLRequest for a webview to consume.
    func authorizeUser(clientID: String, redirectURI: String?, state: String?) -> URLRequest
    // Convert an Authorization code into an Auth Token.
    func convertCodeToToken(code: String, callback: @escaping (_ token: CDKToken?, _ error: CDKSimpleError?) -> ()?)
    // sets a user's session from a token response
    @discardableResult func setUserSessionWith(_ tokenResponse: CDKToken) -> Bool
    // get's the user's session or nothing.
    func getUserSession() -> CDKToken?
}

// Users
protocol CDKUsersProtocol {
    // get an authenticated user
    func user() // broadcasts .didGetUser
    // get a user's invitations
}

protocol CDKListsProtocol {
    // get all of a user's lists even the archived ones
    func lists(callback: @escaping (_ list: CDKLists?, _ error: CDKSimpleError?) -> ()?)
    // get a specific user list
    func list(id: Int, callback: @escaping (_ list: CDKList?, _ error: CDKSimpleError?) -> ()?)
    // Update a Specific List, update it's title or archive it.
    // leaving archive nil will do nothing, setting it to true will archive it, setting it to false will unarchive it.
    func updateList(id: Int, title: String?, archive: Bool?, callback: ((_ list: CDKList?, _ error: CDKSimpleError?) -> ())?)
    // Creates a list
    func createList(title: String, callback: ((_ list: CDKList?, _ error: CDKSimpleError?) -> ())?)
    // Reorder a List
    func reorderList(id: Int, callback: ((_ list: CDKLists?, _ error: CDKSimpleError?) -> ())?)
    // Lists
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

    

