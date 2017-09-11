//
//  APIManager.swift
//  CheddarKit
//
//  Created by Karl Weber on 9/9/17.
//  Copyright © 2017 Karl Weber. All rights reserved.
//

import Foundation

class APIManager: NSObject {

    static let sharedInstance = APIManager.init(singleton: true)
    
    let clientID = "65415c5a8311383d2e73a324f362a1a3"
    let clientSecret = "66c8ba7060d13612debcbec386e515a3"
    
    fileprivate init(singleton: Bool) {
        super.init()
    }
    
    required override init() {
        // nothing to see here.
    }
    
    // Authenticated Request
    func loginUser() {
//        let session = getSession()
//        let request = URLRequest(url: URL(string: "https://api.cheddarapp.com")!)
    }
    
    // Authorize a User
    // Returns a URL Request to load into a webview so that we can authorize a user.
    // API Endpoint: oauth/authorize
    func authorizeUser() -> URLRequest {
        
        let user = CDAuthorizeUser(clientID: clientID,
                                   redirectURI: "https://cheddarapp.com",
                                   state: "Cheddar Blue")
        let params = ["client_id": user.clientID]
        let request = makeQueryRequest(host: "https://api.cheddarapp.com/", endpoint: "oauth/authorize", params: params)
        return request
    }
    
    // convertCodeToToken
    // get's a token from the authorize code that we already have.
    // API Endpoint: oath/token
    func convertCodeToToken(code: String, callback: (token: CDTokenResponse?, error: CDSimpleError?)? ) {
        
        let params = ["grant_type": "authorization_code", "code": code]
        let request = makeAuthenticatedRequest(host: "https://api.cheddarapp.com/", endpoint: "oauth/token", params: params)
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: request) { (data, response, error) in
            
            if let data = data {
                // we got us some data
                
                // to spit out whatever is coming from the api ucomment below
//                if let returnData = String(data: data, encoding: .utf8) {
//                    print(returnData)
//                }
                
                let decoder = JSONDecoder()
                decoder.dataDecodingStrategy = .deferredToData
                do {
                    let decoded = try decoder.decode(CDTokenResponse.self, from: data)
                    print("decoded: \(decoded)")
                    // success!
                    
                } catch {
                    
                    do {
                        let decoded = try decoder.decode(CDSimpleError.self, from:data)
                        print("We've got an error.")
                        print("\(decoded.error)")
                    } catch {
                        do {
                            if let returnData = String(data: data, encoding: .utf8) {
                                print("ok what we got?")
                                print(returnData)
                            }
                        }
                    }
                }
            }
            
        }.resume()
    }
    
    // utilities
    private func getSession() -> URLSession {
        return URLSession(configuration: URLSessionConfiguration.default)
    }
    
    private func encode(parametersToQueryString params: [String: String]) -> String {
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
    
    private func makeQueryRequest(host: String?,
                             endpoint: String,
                             params: [String: String]?) -> URLRequest {

        var paramString = ""
        if let params = params {
            paramString = encode(parametersToQueryString: params)
        }
        
        var h = "https://api.cheddarapp.com/"
        if let hi = host  {
            h = hi
        }
        
        let request = URLRequest(url: URL(string: h + endpoint + "?" + paramString)!)

        return request
    }
    
    // Make an authenticated post request using generic parameters.
    private func makeAuthenticatedRequest(host: String?,
                                          endpoint: String,
                                          params: [String: String]?) -> URLRequest {
        
        var paramString = ""
        if let params = params {
            paramString = encode(parametersToQueryString: params)
        }
        
        var h = "https://api.cheddarapp.com/"
        if let hi = host  {
            h = hi
        }
        
        let loginString = String(format: "%@:%@", clientID, clientSecret)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
        
        var request = URLRequest(url: URL(string: h + endpoint)!)
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









