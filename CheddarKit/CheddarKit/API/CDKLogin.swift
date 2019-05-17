//
//  CDKLogin.swift
//  CheddarKit
//
//  Created by Karl Weber on 9/10/17.
//  Copyright © 2017 Karl Weber. All rights reserved.
//

import UIKit
import SimpleKeychain

// CDKLogin
extension CheddarKit: CDKAuthenticationProtocol {
    
    // Authorize a User
    // Returns a URL Request to load into a webview so that we can authorize a user.
    // API Endpoint: oauth/authorize
    func authorizeUser(clientID: String, redirectURI: String?, state: String?) -> URLRequest {
        var params = ["client_id": clientID]
        if let redirectURI = redirectURI {
            params["redirect_uri"] = redirectURI
        }
        if let state = state {
            params["state"] = state
        }
        let request = makeQueryRequest(host: "https://api.cheddarapp.com/", endpoint: "oauth/authorize", params: params)
        return request
    }
    
    // convertCodeToToken
    // get's a token from the authorize code that we already have.
    // API Endpoint: oauth/token
    func convertCodeToToken(code: String, callback: @escaping (_ token: CDKToken?, _ error: CDKSimpleError?) -> ()?) {
        
        let request = makeTokenRequest(host: "https://api.cheddarapp.com/", endpoint: "oauth/token", code: code)
        
        let session = getSession()
        
        session.dataTask(with: request) { (data, response, error) in
            
            if let data = data {
                // to spit out whatever is coming from the api uncomment below
                //                if let returnData = String(data: data, encoding: .utf8) {
                //                    print(returnData)
                //                }
                
                let decoder = JSONDecoder()
                decoder.dataDecodingStrategy = .deferredToData
                do {
                    let decoded = try decoder.decode(CDKToken.self, from: data)
                    print("decoded: \(decoded)")
                    // success!
                    callback(decoded, nil)
                    
                } catch {
                    
                    do {
                        let decoded = try decoder.decode(CDKSimpleError.self, from:data)
                        print("We've got an error.")
                        print("\(decoded.error)")
                        callback(nil, decoded)
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
    
    // Save the entire user Session
    @discardableResult func setUserSessionWith(_ tokenResponse: CDKToken) -> Bool {
        
        // alright, we have to encode the user session into the keychain
        let encoder = JSONEncoder()
        do {
            let serializedToken = try encoder.encode(tokenResponse)
            let json = String(data: serializedToken, encoding: .utf8)! // {"name":"Brad","age":53}
            A0SimpleKeychain().setString(json, forKey: CDKSessionKey)
            return true
        } catch {
            return false
        }
    }
    
    // returns a user session or nil.
    func getUserSession() -> CDKToken? {
        let json = A0SimpleKeychain().string(forKey: CDKSessionKey)
        let decoder = JSONDecoder()
        do {
            if let jsonStuff = json?.data(using: .utf8) {
                let token = try decoder.decode(CDKToken.self, from: jsonStuff)
                return token
            }
            return nil
        } catch {
            return nil
        }
    }
    
}
