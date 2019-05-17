//
//  CDKContract.swift
//  CheddarKit
//
//  Created by Karl Weber on 9/11/17.
//  Copyright © 2017 Karl Weber. All rights reserved.
//

import UIKit

enum CDKAPIError : Error {
    case networkingError(Error)
    case serverError // 500 responses
    case requestError(Int, String) // HTTP 4xx serires errors
    case invalidResponse // a Catch All error.
    case decodingError(DecodingError)
}

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
    func lists(callback: @escaping (Result<CDKLists, CDKAPIError>) -> Void)
    // get a specific user list
    func list(id: Int, callback: @escaping (Result<CDKList, CDKAPIError>) -> Void )
    // Update a Specific List, update it's title or archive it.
    // leaving archive nil will do nothing, setting it to true will archive it, setting it to false will unarchive it.
    func updateList(id: Int, title: String?, archive: Bool?, callback: ((_ list: CDKList?, _ error: CDKSimpleError?) -> ())?)
    // Creates a list
    func createList(title: String, callback: @escaping (Result<CDKList, CDKAPIError>) -> Void)
    // Reorder a List
    func reorder(lists: CDKLists, callback: @escaping (Result<CDKLists, CDKAPIError>) -> Void)
    
    // Sharing
    func share(list: CDKList, withEmails: [String], callback: @escaping (Result<CDKSuccess, CDKAPIError>) -> Void)
//    func unshare
//    func members

}

protocol CDKTasksProtocol {
    // Tasks
        // show all tasks in a List
        func tasks(fromList: Int, callback: @escaping (Result<CDKTasks, CDKAPIError>) -> Void)
        // show a task
        func task(withId: Int, callback: ((_ tasks: CDKTask?, _ error: CDKSimpleError?) -> ())?)
        // update a task
        func update(task: CDKTask, withText: String?, archive: Bool?, complete: Bool?, callback: ((_ task: CDKTask?, _ error: CDKSimpleError?) -> ())?)
        // archive a specific task
        func archive(task: CDKTask, callback: @escaping (Result<CDKTask, CDKAPIError>) -> Void)
        //  unarchive a specific task
        func unarchive(task: CDKTask, callback: @escaping (Result<CDKTask, CDKAPIError>) -> Void)
        // create a task
        func create(taskWithText: String, forList: Int, callback: ((_ list: CDKTask?, _ error: CDKSimpleError?) -> ())?)
        // move a task to a new list
        func move(task: CDKTask, toList: CDKList, callback: ((_ list: CDKTask?, _ error: CDKSimpleError?) -> ())?)
        // reorder tasks in a list
        func reorder(tasks: CDKTasks, callback: ((_ tasks: CDKTasks?, _ error: CDKSimpleError?) -> ())?)
        // archive all tasks in a list
        func archive(allTasksInList: CDKList, callback: ((_ task: CDKTask?, _ error: CDKSimpleError?) -> ())?)
        // archive completed tasks in a list
        func archive(completedTasksInList: CDKList, callback: ((_ task: CDKTask?, _ error: CDKSimpleError?) -> ())?)
    
}

protocol CDKMembersProtocol {
    // Members
        // show a list's members
        func members(inList: CDKList, callback: @escaping (Result<CDKMembers, CDKAPIError>) -> Void)
        // remove member's from a list
        func remove(member: CDKUser, fromList: CDKList)
    
    // invitations
        // Get Invitations for a user.
        func invitations(forUser: CDKUser)
        // delete an invitation
        func delete(invitation: CDKInvitation)
        // accept an invitation
        func accept(invitation: CDKInvitation)
    
}

protocol CDKEntitiesProtocol {
    // Entities
}

protocol CDKRealtimeProtocol {
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
}
