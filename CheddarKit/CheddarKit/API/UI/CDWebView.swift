//
//  CDWebView.swift
//  CheddarKit
//
//  Created by Karl Weber on 9/10/17.
//  Copyright © 2017 Karl Weber. All rights reserved.
//

import UIKit
import WebKit

class CDWebView: UIViewController, WKUIDelegate, WKNavigationDelegate {
    
    var webView = WKWebView(frame: .zero, configuration: WKWebViewConfiguration())
    var initialRequest: URLRequest?
    var authDelegate: CDWebViewDelegate?
    
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
        
        let manager = APIManager.sharedInstance
        let request = manager.authorizeUser()
        // Do any additional setup after loading the view.
        setupWebView()
        webView.load(request)
        print("load request!")
    }
    
    func setupWebView() {
        
        webView.uiDelegate = self
        webView.navigationDelegate = self
        view = webView
        
//        self.view.addSubview(webView)
//        webView.translatesAutoresizingMaskIntoConstraints = false
//        webView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
//        webView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
//        webView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
//        webView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
//        webView.backgroundColor = .black
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        print("intercepting urls!")
        
        let app = UIApplication.shared
        let url = navigationAction.request.url
        let myScheme = "cheddar"
        
        if let url = url {
            if url.scheme == myScheme && app.canOpenURL(url) {

                if let values = url.queryParameters {
//                    for (key, value) in comps {
//                        print("\(key): \(value)")
//                    }
                    if let code = values["code"]  {
                        let response = CDAuthCode(code: code,
                                                  response: "success",
                                                  message: "Successfully did it!")
//                        self.authDelegate?.CheddarAuthResponse(codeResponse: response)
                        self.cheddarAuthResponse(codeResponse: response)
                        decisionHandler(.cancel)
                        return
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

// The CDWebViewDelegate does 1 thing, it either returns a code for successfull authentication.
// or it returns an error.
protocol CDWebViewDelegate {
    func cheddarAuthResponse(codeResponse: CDAuthCode)
}

extension CDWebView: CDWebViewDelegate {
    
    func cheddarAuthResponse(codeResponse: CDAuthCode) {
        if codeResponse.response == "success" {
            // it worked
            // parse that code and try to get an auth token.
            print(codeResponse.code)
            APIManager.sharedInstance.convertCodeToToken(code: codeResponse.code)
        } else {
            // post errors
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