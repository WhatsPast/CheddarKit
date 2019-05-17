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
    
    // get all the tasks from a list
    
    func task(withId task_id: Int, callback: ((_ task: CDKTask?, _ error: CDKSimpleError?) -> ())?) {
        if let userSession = CheddarKit.sharedInstance.getUserSession() {
            let request = makeAuthenticatedRequest(host: "https://api.cheddarapp.com/", endpoint: "v1/tasks/\(task_id)", method: "GET", params: nil, token: userSession.access_token)
            
            getSession().dataTask(with: request) { (data, response, error) in
                if let data = data {
                    if let returnData = String(data: data, encoding: .utf8) { print(returnData) } // To Debug
                    let decoder = JSONDecoder(); decoder.dataDecodingStrategy = .deferredToData
                    do {
                        let decoded = try decoder.decode(CDKTask.self, from: data)
                        callback?(decoded, nil)
                    } catch {
                        do {
                            let decoded = try decoder.decode(CDKSimpleError.self, from:data)
                            callback?(nil, decoded)
                        } catch {
                        }
                    }
                } // End Data
                }.resume()
        } // End Session
    }
    
    func update(task: CDKTask, withText text: String?, archive: Bool?, complete: Bool?, callback: ((_ task: CDKTask?, _ error: CDKSimpleError?) -> ())?) {
        if let userSession = CheddarKit.sharedInstance.getUserSession() {
            var params = [String: String]()
            if let text = text {
                params["task[text]"] = text
            }
            
            if let archive = archive {
                if archive == true {
                    params["task[archived_at]"] = self.dateFormatter().string(from: Date())
                } else {
                    params["task[archived_at]"] = ""
                }
            }
            
            if let complete = complete {
                if complete == true {
                    params["task[completed]"] = "true"
                } else {
                    params["task[completed]"] = "false"
                }
            }
            
            let request = makeAuthenticatedRequest(host: "https://api.cheddarapp.com/", endpoint: "v1/tasks/\(task.id)", method: "PUT", params: params, token: userSession.access_token)
            
            getSession().dataTask(with: request) { (data, response, error) in
                if let data = data {
                    if let returnData = String(data: data, encoding: .utf8) { print(returnData) } // To Debug
                    let decoder = JSONDecoder(); decoder.dataDecodingStrategy = .deferredToData
                    do {
                        let decoded = try decoder.decode(CDKTask.self, from: data)
                        callback?(decoded, nil)
                    } catch {
                        do {
                            let decoded = try decoder.decode(CDKSimpleError.self, from:data)
                            callback?(nil, decoded)
                        } catch {
                        }
                    }
                } // End Data
            }.resume()
        } // End Session
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
    
    func create(taskWithText text: String, forList list_id: Int, callback: ((_ task: CDKTask?, _ error: CDKSimpleError?) -> ())?) {
        if let userSession = CheddarKit.sharedInstance.getUserSession() {
            var params = [String: String]()
            params["task[text]"] = text
            
            let request = makeAuthenticatedRequest(host: "https://api.cheddarapp.com/", endpoint: "v1/lists/\(list_id)/tasks", method: "POST", params: params, token: userSession.access_token)
            
            getSession().dataTask(with: request) { (data, response, error) in
                if let data = data {
                    if let returnData = String(data: data, encoding: .utf8) { print(returnData) } // To Debug
                    let decoder = JSONDecoder(); decoder.dataDecodingStrategy = .deferredToData
                    do {
                        let decoded = try decoder.decode(CDKTask.self, from: data)
                        callback?(decoded, nil)
                    } catch {
                        do {
                            let decoded = try decoder.decode(CDKSimpleError.self, from:data)
                            callback?(nil, decoded)
                        } catch {
                        }
                    }
                } // End Data
                }.resume()
        } // End Session
    }
    
    func move(task: CDKTask, toList list: CDKList, callback: ((_ task: CDKTask?, _ error: CDKSimpleError?) -> ())?) {
        if let userSession = CheddarKit.sharedInstance.getUserSession() {
            var params = [String: String]()
            params["task[list_id]"] = "\(list.id)"
            
            let request = makeAuthenticatedRequest(host: "https://api.cheddarapp.com/", endpoint: "v1/tasks/\(task.id)/move", method: "PUT", params: params, token: userSession.access_token)
            
            getSession().dataTask(with: request) { (data, response, error) in
                if let data = data {
                    if let returnData = String(data: data, encoding: .utf8) { print(returnData) } // To Debug
                    let decoder = JSONDecoder(); decoder.dataDecodingStrategy = .deferredToData
                    do {
                        let decoded = try decoder.decode(CDKTask.self, from: data)
                        callback?(decoded, nil)
                    } catch {
                        do {
                            let decoded = try decoder.decode(CDKSimpleError.self, from:data)
                            callback?(nil, decoded)
                        } catch {
                        }
                    }
                } // End Data
                }.resume()
        } // End Session
    }
    
    func reorder(tasks: CDKTasks, callback: ((_ tasks: CDKTasks?, _ error: CDKSimpleError?) -> ())?) {
        if let userSession = CheddarKit.sharedInstance.getUserSession() {
            
            var orderedTasks = [String]()
            for task in tasks {
                orderedTasks.append("task[]=\(task.id)")
            }
            let params = encode(arrayToQueryString: orderedTasks)
            
            let request = makeAuthenticatedRequest(host: "https://api.cheddarapp.com/", endpoint: "v1/lists/\(tasks[0].list_id)/tasks/reorder", method: "POST", paramString: params, token: userSession.access_token)
            
            getSession().dataTask(with: request) { (data, response, error) in
                if let data = data {
                    if let returnData = String(data: data, encoding: .utf8) {
                        print(returnData)
                    }
                }
                if let response = response {
                    let httpResponse = (response as! HTTPURLResponse)
                    if httpResponse.statusCode == 204 {
                    } else {
                    }
                }
            }.resume()
        }
    }
    
    func archive(allTasksInList list: CDKList, callback: ((_ task: CDKTask?, _ error: CDKSimpleError?) -> ())?) {
        if let userSession = CheddarKit.sharedInstance.getUserSession() {
            
            
            let request = makeAuthenticatedRequest(host: "https://api.cheddarapp.com/", endpoint: "v1/lists/\(list.id)/tasks/archive_all", method: "POST", paramString: nil, token: userSession.access_token)
            
            getSession().dataTask(with: request) { (data, response, error) in
                if let data = data {
                    if let returnData = String(data: data, encoding: .utf8) {
                        print(returnData)
                    }
                }
                if let response = response {
                    let httpResponse = (response as! HTTPURLResponse)
                    if httpResponse.statusCode == 204 {
                    } else {
                    }
                }
            }.resume()
        }
    }
    
    func archive(completedTasksInList list: CDKList, callback: ((_ task: CDKTask?, _ error: CDKSimpleError?) -> ())?) {
        if let userSession = CheddarKit.sharedInstance.getUserSession() {
            
            let request = makeAuthenticatedRequest(host: "https://api.cheddarapp.com/", endpoint: "v1/lists/\(list.id)/tasks/archive_completed", method: "POST", paramString: nil, token: userSession.access_token)
            
            getSession().dataTask(with: request) { (data, response, error) in
                if let data = data {
                    if let returnData = String(data: data, encoding: .utf8) {
                        print(returnData)
                    }
                }
                if let response = response {
                    let httpResponse = (response as! HTTPURLResponse)
                    if httpResponse.statusCode == 204 {
                    } else {
                    }
                }
            }.resume()
        }
    }
    
    
}
