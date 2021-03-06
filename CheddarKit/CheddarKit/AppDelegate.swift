//
//  AppDelegate.swift
//  CheddarKit
//
//  Created by Karl Weber on 9/9/17.
//  Copyright © 2017 Karl Weber. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        window?.backgroundColor = .whiteFive
        
        if CheddarKit.sharedInstance.getUserSession() == nil {
            loadLoginView()
        } else {
            loadApplication()
        }
        
        // This is the Old Auth Flow
//        if CheddarKit.sharedInstance.getUserSession() == nil {
//            let webView = CDKWebView()
//            window?.rootViewController = webView
//
//            webView.authCodeCallback = { (code, error) -> () in
//                if code != nil {
//                    self.handleAuth(code: code!)
//                }
//            }
//        } else {
//            let session = CheddarKit.sharedInstance.getUserSession()
//            loadApplication()
//        }
        
        window?.makeKeyAndVisible()
        return true
    }
    
    func loadLoginView() {
        window?.rootViewController = LoginViewController()
    }
    
    func loadApplication() {
        window?.rootViewController = NavigationController()
        (window?.rootViewController as! NavigationController).pushViewController(ListsViewController(), animated: true)
    }
    
    func handleAuth(code: String) {
        CheddarKit.sharedInstance.convertCodeToToken(code: code, callback:  { token, error in
            print("I love it here.")
            if let token = token {
                self.handleToken(token: token)
            } else if let _ = error {
                // handle the error
            }
        })
    }
    
    func handleToken(token: CDKToken) {
        // save that there token
        if CheddarKit.sharedInstance.setUserSessionWith(token) {
            // we're officially logged in so let's show us some lists.
            DispatchQueue.main.sync {
                loadApplication()
            }
        }
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

