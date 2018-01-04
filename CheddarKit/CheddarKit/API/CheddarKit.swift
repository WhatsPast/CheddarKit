//
//  CheddarKit.swift
//  CheddarKit
//
//  Created by Karl Weber on 9/9/17.
//  Copyright © 2017 Karl Weber. All rights reserved.
//

import Foundation

class CheddarKit: NSObject {

    static let sharedInstance = CheddarKit.init(singleton: true)
    
    let clientID = "65415c5a8311383d2e73a324f362a1a3"
    let clientSecret = "66c8ba7060d13612debcbec386e515a3"
    
    private init(singleton: Bool) {
        super.init()
    }
    
    required override init() {
        // nothing to see here.
        fatalError("Just stop it. Please just stop. This has to be used as a Singleton.")
    }
    
    // utilities
    func getSession() -> URLSession {
        return URLSession(configuration: URLSessionConfiguration.default)
    }
    
    func encode(parametersToQueryString params: [String: String]) -> String {
        var paramString = ""
        for (key, value) in params {
            let escapedKey = key.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            let escapedValue = value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            paramString = paramString + "\(escapedKey)=\(escapedValue)&"
        }
        return paramString
    }
    
//    private func encode(parametersToStrings params: [String: String]) -> [String] {
//        var paramStrings: [String]
//        var paramString = ""
//        for (key, value) in params {
//            let escapedKey = key.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
//            let escapedValue = value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
//            paramString = "\(escapedKey)=\(escapedValue)"
//            paramStrings.append(paramString)
//        }
//        return paramStrings
//    }
    
//    private func encode(parametersToJSON params: [String: String]) -> String {
//        var paramString = ""
//        for (key, value) in params {
//            let escapedKey = key.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
//            let escapedValue = value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
//            paramString = paramString + "\(escapedKey)=\(escapedValue)&"
//        }
//        return paramString
//    }
    
    func makeQueryRequest(host: String = "https://api.cheddarapp.com/",
                             endpoint: String,
                             params: [String: String]?) -> URLRequest {

        var paramString = ""
        if let params = params {
            paramString = encode(parametersToQueryString: params)
        }
        
        let request = URLRequest(url: URL(string: host + endpoint + "?" + paramString)!)

        return request
    }
    
    // Make an authenticated post request using generic parameters.
    func makeAuthenticatedRequest(host: String = "https://api.cheddarapp.com/",
                              endpoint: String,
                                method: String = "GET",
                                params: [String: String]?,
                                 token: String) -> URLRequest {
        
        print("Our Token: \(token)")
        print("URL: \(host)\(endpoint)")

        // headers
        var request = URLRequest(url: URL(string: host + endpoint)!)
        request.httpMethod = method
        // Token Header
        request.setValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        
        // parameters
        var paramString = ""
        if let params = params {
            paramString = encode(parametersToQueryString: params)
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-type")
            request.httpBody = paramString.data(using: .utf8)
        }
        
        return request
    }
    
    
    // Make an authenticated post request using generic parameters.
    func makeTokenRequest(host: String = "https://api.cheddarapp.com/",
                                      endpoint: String,
                                          code: String) -> URLRequest {
        
        let params = ["grant_type": "authorization_code", "code": code]
        let paramString = encode(parametersToQueryString: params)
        
        let loginString = String(format: "%@:%@", clientID, clientSecret)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
        
        var request = URLRequest(url: URL(string: host + endpoint)!)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-type")
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        request.httpBody = paramString.data(using: .utf8)
        
        //        if let token = token {
        //            request.setValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        //        }
        
        return request
    }
}
