//
//  APIManager.swift
//  CheddarKit
//
//  Created by Karl Weber on 9/9/17.
//  Copyright © 2017 Karl Weber. All rights reserved.
//

import Foundation


class APIManager: NSObject {

    // MARK: - Singleton
    static let sharedInstance = APIManager.init(singleton: true)
    
    fileprivate init(singleton: Bool) {
        if (singleton) {
            super.init()
        }
        else {
            fatalError("APIManager must be used as Singleton")
        }
    }
    
}

