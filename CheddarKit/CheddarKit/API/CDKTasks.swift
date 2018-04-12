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
    
    // get all the tasks from a list
    func tasks(fromList list_id: Int, callback: ((_ tasks: CDKTasks?, _ error: CDKSimpleError?) -> ())?) {
        if let userSession = CheddarKit.sharedInstance.getUserSession() {
            let request = makeAuthenticatedRequest(host: "https://api.cheddarapp.com/", endpoint: "v1/lists/\(list_id)/tasks", method: "GET", params: nil, token: userSession.access_token)
            
            getSession().dataTask(with: request) { (data, response, error) in
                if let data = data {
                     if let returnData = String(data: data, encoding: .utf8) {
                        print(returnData)
                     }
                    print("We got some valid JSON! Now let's decode it.")
                    
                    let decoder = JSONDecoder()
                    decoder.dataDecodingStrategy = .deferredToData
                    do {
                        let decoded = try decoder.decode(CDKTasks.self, from: data)
                        //                        print("decoded: \(decoded)")
                        // success!
                        callback?(decoded, nil)
                    } catch {
                        
                        do {
                            let decoded = try decoder.decode(CDKSimpleError.self, from:data)
                            print("We've got an error.")
                            print("\(decoded.error)")
                            callback?(nil, decoded)
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
    
    
    func task(withId task_id: Int, callback: @escaping (CDKTask?, CDKSimpleError?) -> ()?) {
        //
    }
    
    
}
