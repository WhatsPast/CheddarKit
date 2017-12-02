//
//  Models.swift
//  CheddarKit
//
//  Created by Karl Weber on 9/11/17.
//  Copyright © 2017 Karl Weber. All rights reserved.
//
// Alright so we need to store and persist data for the example project.
// But that's outside of the scope of this whole thing, so we're just going to
// store data in NSUserDefaults.

import UIKit

class CDModel: NSObject {
    static let sharedInstance = CDModel.init(singleton: true)

    fileprivate init(singleton: Bool) {
        super.init()
    }

    required override init() {
        // nothing to see here.
    }

    // Utilities
    private func set(_ value: String, forKey key : String) -> Bool {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: key)
        return true
    }
    private func get(forKey key: String) -> (Bool, String) {
        let defaults = UserDefaults.standard
        if let data = defaults.string(forKey: key) {
            return (true, data)
        } else {
            return (false, "")
        }
    }

    // Models
    // Authentication
    @discardableResult func setUserToken(_ token: String) -> Bool {
        return set(token, forKey: "user_token")
    }
    func getUserToken() -> (Bool, String) {
        return get(forKey: "user_token")
    }
    
    // Save the entire user Session
    @discardableResult func setUserSessionWith(tokenResponse: CDTokenResponse) -> Bool {
        
        return false
    }

}
