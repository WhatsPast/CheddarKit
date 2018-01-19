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
        if let userSession = CheddarKit.sharedInstance.getUserSession() {
            
            let request = makeAuthenticatedRequest(host: "https://api.cheddarapp.com/", endpoint: "v1/lists/\(id)", method: "GET", params: nil, token: userSession.access_token)
            
            getSession().dataTask(with: request) { (data, response, error) in
                if let data = data {
                    // to spit out whatever is coming from the api uncomment below
//                    if let returnData = String(data: data, encoding: .utf8) {
//                        print(returnData)
//                    }
                    print("We got some valid JSON! Now let's decode it.")
                    
                    let decoder = JSONDecoder()
                    decoder.dataDecodingStrategy = .deferredToData
                    do {
                        let decoded = try decoder.decode(CDKList.self, from: data)
                        //                        print("decoded: \(decoded)")
                        // success!
//                        callback(decoded, nil)
                    } catch {
                        
                        do {
                            let decoded = try decoder.decode(CDKSimpleError.self, from:data)
                            print("We've got an error.")
                            print("\(decoded.error)")
//                            callback(nil, decoded)
                        } catch {

                        }
                    }
                } // End Data
            }.resume()
        }
    }
    
    func updateList(id: Int, title: String?, archive: Bool?) {
        if let userSession = CheddarKit.sharedInstance.getUserSession() {
            
            var params = [String: String]()
            
            // title
            if let title = title {
                params["list[title]"] = title
            }
            
            // archive
            if let archive = archive {
                if archive {
                    let dateFormatter = DateFormatter()
                    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                    // EX: "2012-07-02T18:50:53Z"
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                    dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
                    dateFormatter.date(from: "")
                    
                    let date = Date(timeIntervalSinceNow: 0)
                    let dateString = dateFormatter.string(from: date)
                    
                    params["list[archived_at]"] = dateString
                    print("datString: \(dateString).")
                } else {
                    params["list[archived_at]"] = ""
                }
            }
            
            let request = makeAuthenticatedRequest(host: "https://api.cheddarapp.com/",
                                                   endpoint: "v1/lists/\(id)",
                                                   method: "PUT",
                                                   params: params,
                                                   token: userSession.access_token)
            
            getSession().dataTask(with: request) { (data, response, error) in
                if let data = data {
                    // to spit out whatever is coming from the api uncomment below
                    if let returnData = String(data: data, encoding: .utf8) {
                        print(returnData)
                    }
                    print("We got some valid JSON! Now let's decode it.")
                    
                    let decoder = JSONDecoder()
                    decoder.dataDecodingStrategy = .deferredToData
                    do {
                        let decoded = try decoder.decode(CDKList.self, from: data)
                        print("decoded: \(decoded)")
                        // success!
                        //                        callback(decoded, nil)
                    } catch {
                        
                        do {
                            let decoded = try decoder.decode(CDKSimpleError.self, from:data)
                            print("We've got an error.")
                            print("\(decoded.error)")
                            //                            callback(nil, decoded)
                        } catch {
                            
                        }
                    }
                } // End Data
            }.resume()
            
            
        }
        
    }
    
}
