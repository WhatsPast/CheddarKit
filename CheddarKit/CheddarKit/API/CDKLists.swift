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

    func lists(callback: @escaping (_ list: CDKLists?, _ error: CDKSimpleError?) -> ()?) {
        
        if let userSession = CheddarKit.sharedInstance.getUserSession() {
        
            let request = makeAuthenticatedRequest(host: "https://api.cheddarapp.com/", endpoint: "v1/lists", method: "GET", params: nil, token: userSession.access_token)
            
            getSession().dataTask(with: request) { (data, response, error) in
                if let data = data {
                    // to spit out whatever is coming from the api uncomment below
                    // if let returnData = String(data: data, encoding: .utf8) {
                    //    print(returnData)
                    // }
                    print("We got some valid JSON! Now let's decode it.")
                    
                    let decoder = JSONDecoder()
                    decoder.dataDecodingStrategy = .deferredToData
                    do {
                        let decoded = try decoder.decode(CDKLists.self, from: data)
//                        print("decoded: \(decoded)")
                        // success!
                        callback(decoded, nil)
                    } catch {
                        
                        do {
                            let decoded = try decoder.decode(CDKSimpleError.self, from:data)
                            print("We've got an error.")
                            print("\(decoded.error)")
                            callback(nil, decoded)
                        } catch {
    //                        if let returnData = String(data: data, encoding: .utf8) {
    //                            print("ok what we got?")
    //                            print(returnData)
    //                        }
                        }
                    }
                } // End Data
            }.resume()
        }
    }
    func list(id: Int) {
        
    }
    
}
