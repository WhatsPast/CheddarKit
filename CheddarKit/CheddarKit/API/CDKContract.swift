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
    func convertCodeToToken(code: String, callback: @escaping (_ token: CDKToken?, _ error: CDKSimpleError?) -> Void)
    // sets a user's session from a token response
    @discardableResult func setUserSessionWith(_ tokenResponse: CDKToken) -> Bool
    // get's the user's session or nothing.
    func getUserSession() -> CDKToken?
    
    // Username / Password Login Flow, only authorized apps can actually use this flow
    func login(username: String, password: String, callback: @escaping (Result<CDKToken, CDKAPIError>) -> Void)
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
    // Update a Specific List, archive it.
    // leaving archive nil will do nothing, setting it to true will archive it, setting it to false will unarchive it.
    func update(list: CDKList, archive: Bool?, callback: @escaping(Result<CDKList, CDKAPIError>) -> Void)
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
        // get a task
        func task(withId: Int, callback: @escaping (Result<CDKTask, CDKAPIError>) -> Void)
        // update a task
        func update(task: CDKTask, archive: Bool?, complete: Bool?, callback: @escaping (Result<CDKTask, CDKAPIError>) -> Void)
        // archive a specific task
        func archive(task: CDKTask, callback: @escaping (Result<CDKTask, CDKAPIError>) -> Void)
        //  unarchive a specific task
        func unarchive(task: CDKTask, callback: @escaping (Result<CDKTask, CDKAPIError>) -> Void)
        // create a task
        func create(taskWithText: String, forList: Int, callback: @escaping (Result<CDKTask, CDKAPIError>) -> Void)
        // move a task to a new list
        func move(task: CDKTask, toList list: CDKList, callback: @escaping (Result<CDKTask, CDKAPIError>) -> Void)
        // reorder tasks in a list
        func reorder(tasks: CDKTasks, callback: @escaping (Result<CDKTasks, CDKAPIError>) -> Void)
        // archive all tasks in a list
        func archive(allTasksInList: CDKList, callback: @escaping (Result<CDKSuccess, CDKAPIError>) -> Void)
        // archive completed tasks in a list
        func archive(completedTasksInList: CDKList, callback: @escaping (Result<CDKSuccess, CDKAPIError>) -> Void)
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
