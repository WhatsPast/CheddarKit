//
//  CDKLists.swift
//  CheddarKit
//
//  Created by Karl Weber on 1/3/18.
//  Copyright © 2018 Karl Weber. All rights reserved.
//

import UIKit
import SimpleKeychain

// CDKLists
extension CheddarKit: CDKListsProtocol {
    
    func lists(callback: @escaping (Result<CDKLists, CDKAPIError>) -> Void) {
        if let userSession = CheddarKit.sharedInstance.getUserSession() {
            let request = makeAuthenticatedRequest(host: baseURL.absoluteString, endpoint: "lists/", method: "GET", params: nil, token: userSession.access_token)
            perform(request: request, completion: parseDecodable(completion: callback))
        }
    }
    
    func list(id: Int, callback: @escaping (Result<CDKList, CDKAPIError>) -> Void) {
        if let userSession = CheddarKit.sharedInstance.getUserSession() {
            let request = makeAuthenticatedRequest(host: baseURL.absoluteString, endpoint: "lists/\(id)", method: "GET", params: nil, token: userSession.access_token)
            perform(request: request, completion: parseDecodable(completion: callback))
        }
    }
    
    func createList(title: String, callback: @escaping (Result<CDKList, CDKAPIError>) -> Void) {
        if let userSession = CheddarKit.sharedInstance.getUserSession() {
            let request = makeAuthenticatedRequest(host: baseURL.absoluteString, endpoint: "lists/", method: "POST", params: ["list[title]": title], token: userSession.access_token)
            perform(request: request, completion: parseDecodable(completion: callback))
        }
    }
    
    func update(list: CDKList, archive: Bool?, callback: @escaping(Result<CDKList, CDKAPIError>) -> Void) {
        if let userSession = CheddarKit.sharedInstance.getUserSession() {
            var params = [String: String]()
            params["list[title]"] = list.title
            
            // archive
            if let archive = archive {
                if archive {
                    params["list[archived_at]"] = nowDateString()
                } else {
                    params["list[archived_at]"] = ""
                }
            }
            
            let request = makeAuthenticatedRequest(host: baseURL.absoluteString, endpoint: "lists/\(list.id)", method: "PUT", params: params, token: userSession.access_token)
            perform(request: request, completion: parseDecodable(completion: callback))
        }
    }
    
    func reorder(lists: CDKLists, callback: @escaping (Result<CDKLists, CDKAPIError>) -> Void) {
        if let userSession = CheddarKit.sharedInstance.getUserSession() {
            
            var orderedLists = [String]()
            for list in lists {
                orderedLists.append("list[]=\(list.id)")
            }
            let params = encode(arrayToQueryString: orderedLists)
            
            let request = makeAuthenticatedRequest(host: baseURL.absoluteString, endpoint: "lists/reorder", method: "POST", paramString: params, token: userSession.access_token)
            perform(request: request, completion: parseDecodable(completion: callback))
        }
    }
    
    func share(list: CDKList, withEmails emails: [String], callback: @escaping (Result<CDKSuccess, CDKAPIError>) -> Void) {
        
        if let userSession = CheddarKit.sharedInstance.getUserSession() {
            // Get those emails munched together
            var orderedEmails = [String]()
            for email in emails {
                orderedEmails.append("user[email][]=\(email)")
            }
            let params = encode(arrayToQueryString: orderedEmails)
            
            let path = "lists/\(list.id)/members"
            let request = makeAuthenticatedRequest(host: baseURL.absoluteString, endpoint: path, method: "POST", paramString: params, token: userSession.access_token)
            perform(request: request, completion: parseDecodable(completion: callback))
        }
    }

    
}
