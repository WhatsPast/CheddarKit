//
//  CDKWebView.swift
//  CheddarKit
//
//  Created by Karl Weber on 9/10/17.
//  Copyright © 2017 Karl Weber. All rights reserved.
//

import UIKit
import WebKit

class CDKWebView: UIViewController, WKUIDelegate, WKNavigationDelegate {
    
    var webView = WKWebView(frame: .zero, configuration: WKWebViewConfiguration())
    var initialRequest: URLRequest?
    var authDelegate: CDKWebViewDelegate?
    var authCodeCallback: ((_ authCode: String?, _ error: CDKSimpleError?) -> ())?
    var tokenCallback: ((_ token: CDKToken?, _ error: CDKSimpleError?) -> ())?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init(withRequest request: URLRequest) {
        self.init(nibName: nil, bundle: nil)
        initialRequest = request
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let manager = CheddarKit.sharedInstance
//        let request = manager.authorizeUser(clientID: manager.clientID, redirectURI: "https://cheddarapp.com", state: "Cheddar Blue")
        let request = manager.authorizeUser(clientID: manager.clientID, redirectURI: nil, state: nil)
        
        // Do any additional setup after loading the view.
        setupWebView()
        webView.load(request)
    }
    
    func setupWebView() {
        webView.uiDelegate = self
        webView.navigationDelegate = self
        view = webView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
         This interecepts a page redirect so that we can get the key out of it.
         It also gets the token out of it if we can.
     */
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        print("intercepting urls!")
        
        let app = UIApplication.shared
        let url = navigationAction.request.url
        let myScheme = "cheddar"
        
        if let url = url {
            if url.scheme == myScheme && app.canOpenURL(url) {

                if let values = url.queryParameters {
                    if let code = values["code"]  {
                        let response = CDKAuthCode(code: code,
                                                  response: "success",
                                                  message: "Successfully did it!")
                        
                        // this worked, now send back the response.
                        self.cheddarAuthResponse(codeResponse: response, error: nil)
                        decisionHandler(.cancel)
                        return
                    } else {
                        // it didn't work so we have got to figure this out.
                    }
                }
                
                // we should probably implement the app url method thingy.
//                app.open(url, options: ["": ""], completionHandler: { (success) in
//                    // did it work
//                    if success {
//                        // it worked
//                    }
//                })
                decisionHandler(.cancel)
                return
            } else {
//                print("scheme didn't match.")
//                print("scheme: \(String(describing: url.scheme))")
//                print("\(url.absoluteString)")
            }
        }

        decisionHandler(.allow)
        return
    }
}

// The CDKWebViewDelegate does 1 thing, it either returns a code for successfull authentication.
// or it returns an error.
protocol CDKWebViewDelegate {
    func cheddarAuthResponse(codeResponse: CDKAuthCode, error: CDKSimpleError?)
}

extension CDKWebView: CDKWebViewDelegate {
    
    func cheddarAuthResponse(codeResponse: CDKAuthCode, error: CDKSimpleError?) {
        if codeResponse.response == "success" {
            // it worked
            // parse that code and try to get an auth token.
            print(codeResponse.code)
            
            if let acb = authCodeCallback {
                acb(codeResponse.code, nil)
            }            
//            APIManager.sharedInstance.convertCodeToToken(code: codeResponse.code, callback: nil)
        } else {
            if let acb = authCodeCallback {
                acb(nil, error)
            }
        }
    }
}

// Thanks to: https://stackoverflow.com/questions/41421686/swift-get-url-parameters
extension URL {
    
    public var queryParameters: [String: String]? {
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: true), let queryItems = components.queryItems else {
            return nil
        }
        
        var parameters = [String: String]()
        for item in queryItems {
            parameters[item.name] = item.value
        }
        
        return parameters
    }
}
