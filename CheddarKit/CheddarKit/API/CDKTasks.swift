//
//  CDKTasks.swift
//  CheddarKit
//
//  Created by Karl Weber on 4/10/18.
//  Copyright © 2018 Karl Weber. All rights reserved.
//

import UIKit
import SimpleKeychain


// CDKTasks
extension CheddarKit: CDKTasksProtocol {
    
    func tasks(fromList list_id: Int, callback: @escaping (Result<CDKTasks, CDKAPIError>) -> Void) {
        if let userSession = CheddarKit.sharedInstance.getUserSession() {
            let path = "lists/\(list_id)/tasks"
//            let url = baseURL.appendingPathComponent(path)
            let request = makeAuthenticatedRequest(host: baseURL.absoluteString, endpoint: path, method: "GET", params: nil, token: userSession.access_token)
            perform(request: request, completion: parseDecodable(completion: callback))
        }
    }
    
    func task(withId task_id: Int, callback: @escaping (Result<CDKTask, CDKAPIError>) -> Void) {
        if let userSession = CheddarKit.sharedInstance.getUserSession() {
            let request = makeAuthenticatedRequest(host: baseURL.absoluteString, endpoint: "tasks/\(task_id)", method: "GET", params: nil, token: userSession.access_token)
            perform(request: request, completion: parseDecodable(completion: callback))
        }
    }
    
    func update(task: CDKTask, archive: Bool?, complete: Bool?, callback: @escaping (Result<CDKTask, CDKAPIError>) -> Void) {
        if let userSession = CheddarKit.sharedInstance.getUserSession() {
            var params = [String: String]()
            params["task[text]"] = task.text
            
            if let archive = archive {
                params["task[archived_at]"] = ""
                if archive == true {
                    params["task[archived_at]"] = nowDateString() // self.dateFormatter().string(from: Date())
                }
            }
            
            if let complete = complete {
                params["task[completed]"] = "false"
                if complete {
                    params["task[completed]"] = "true"
                }
            }
            
            let request = makeAuthenticatedRequest(host: baseURL.absoluteString, endpoint: "tasks/\(task.id)", method: "PUT", params: params, token: userSession.access_token)
            perform(request: request, completion: parseDecodable(completion: callback))
        }
    }
    
    func archive(task: CDKTask, callback: @escaping (Result<CDKTask, CDKAPIError>) -> Void) {
        if let userSession = CheddarKit.sharedInstance.getUserSession() {
            let params = ["task[archived_at]": self.dateFormatter().string(from: Date())]
            let request = makeAuthenticatedRequest(host: baseURL.absoluteString, endpoint: "tasks/\(task.id)", method: "PUT", params: params, token: userSession.access_token)
            perform(request: request, completion: parseDecodable(completion: callback))
        }
    }
    
    func unarchive(task: CDKTask, callback: @escaping (Result<CDKTask, CDKAPIError>) -> Void) {
        if let userSession = CheddarKit.sharedInstance.getUserSession() {
            let params = ["task[archived_at]": ""]
            let request = makeAuthenticatedRequest(host: baseURL.absoluteString, endpoint: "tasks/\(task.id)", method: "PUT", params: params, token: userSession.access_token)
            perform(request: request, completion: parseDecodable(completion: callback))
        }
    }
    
    func create(taskWithText text: String, forList list_id: Int, callback: @escaping (Result<CDKTask, CDKAPIError>) -> Void) {
        if let userSession = CheddarKit.sharedInstance.getUserSession() {
            let params = ["task[text]": text]
            let request = makeAuthenticatedRequest(host: baseURL.absoluteString, endpoint: "lists/\(list_id)/tasks", method: "POST", params: params, token: userSession.access_token)
            perform(request: request, completion: parseDecodable(completion: callback))
        }
    }
    
    func move(task: CDKTask, toList list: CDKList, callback: @escaping (Result<CDKTask, CDKAPIError>) -> Void) {
        if let userSession = CheddarKit.sharedInstance.getUserSession() {
            var params = [String: String]()
            params["task[list_id]"] = "\(list.id)"
            let request = makeAuthenticatedRequest(host: baseURL.absoluteString, endpoint: "tasks/\(task.id)/move", method: "PUT", params: params, token: userSession.access_token)
            perform(request: request, completion: parseDecodable(completion: callback))
        }
    }
    
    func reorder(tasks: CDKTasks, callback: @escaping (Result<CDKTasks, CDKAPIError>) -> Void) {
        if let userSession = CheddarKit.sharedInstance.getUserSession() {
            var orderedTasks = [String]()
            for task in tasks {
                orderedTasks.append("task[]=\(task.id)")
            }
            let request = makeAuthenticatedRequest(host: baseURL.absoluteString, endpoint: "lists/\(tasks[0].list_id)/tasks/reorder", method: "POST", paramString: encode(arrayToQueryString: orderedTasks), token: userSession.access_token)
            perform(request: request, completion: parseDecodable(completion: callback))
        }
    }
    
    func archive(allTasksInList list: CDKList, callback: @escaping (Result<CDKSuccess, CDKAPIError>) -> Void) {
        if let userSession = CheddarKit.sharedInstance.getUserSession() {
            let request = makeAuthenticatedRequest(host: baseURL.absoluteString, endpoint: "lists/\(list.id)/tasks/archive_all", method: "POST", paramString: nil, token: userSession.access_token)
            perform(request: request, completion: parseDecodable(completion: callback))
        }
    }
    
    func archive(completedTasksInList list: CDKList, callback: @escaping (Result<CDKSuccess, CDKAPIError>) -> Void) {
        if let userSession = CheddarKit.sharedInstance.getUserSession() {
            let request = makeAuthenticatedRequest(host: baseURL.absoluteString, endpoint: "lists/\(list.id)/tasks/archive_completed", method: "POST", paramString: nil, token: userSession.access_token)
            perform(request: request, completion: parseDecodable(completion: callback))
        }
    }
    
}
