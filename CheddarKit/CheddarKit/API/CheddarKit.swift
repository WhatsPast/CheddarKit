//
//  CheddarKit.swift
//  CheddarKit
//
//  Created by Karl Weber on 9/9/17.
//  Copyright © 2017 Karl Weber. All rights reserved.
//

import Foundation

class CheddarKit: NSObject {

    static let sharedInstance = CheddarKit.init(singleton: true)
    
    // Set up the Shared Session
    let session: URLSession
    var baseURL = URL(string: "https://api.cheddarapp.com/v1/")!
    
    // These are sample Keys, They are changed frequently so be sure to add your own to CDKSecrets
    var clientID = "167a530bee50379854f469b8f9b07b7d"
    var clientSecret = "22b9bff290a692da4e14eddb787a8d31"
    
    private init(singleton: Bool) {
        self.session = URLSession.shared
        clientID = CDKSecrets.clientID()
        clientSecret = CDKSecrets.clientSecret()
        super.init()
    }
    
    required override init() {
        // nothing to see here.
        fatalError("Just stop it. Please just stop. This has to be used as a Singleton.")
    }
    
    // utilities
    func getSession() -> URLSession {
        return session
    }
    
    func encode(parametersToQueryString params: [String: String]) -> String {
        var paramString = ""
        for (key, value) in params {
            let escapedKey = key.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            let escapedValue = value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            paramString = paramString + "\(escapedKey)=\(escapedValue)&"
//            print("supposed paramString: \(paramString)")
        }
        return paramString
    }
    
    func encode(arrayToQueryString params: [String]) -> String {
        var paramString = ""
        for item in params {
            paramString = paramString + "\(item)&"
        }
        return paramString
    }
    
    func makeQueryRequest(host: String = "https://api.cheddarapp.com/",
                             endpoint: String,
                             params: [String: String]?) -> URLRequest {

        var paramString = ""
        if let params = params {
            paramString = encode(parametersToQueryString: params)
        }
        
        let request = URLRequest(url: URL(string: host + endpoint + "?" + paramString)!)

        return request
    }
    
    // Make an authenticated post request using generic parameters.
    func makeAuthenticatedRequest(host: String = "https://api.cheddarapp.com/",
                              endpoint: String,
                                method: String = "GET",
                                params: [String: String]?,
                                 token: String) -> URLRequest {

        // headers
        var request = URLRequest(url: URL(string: host + endpoint)!)
        request.httpMethod = method
        // Token Header
        request.setValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        
        // parameters
        var paramString = ""
        if let params = params {
            paramString = encode(parametersToQueryString: params)
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-type")
            request.httpBody = paramString.data(using: .utf8)
        }
        
        return request
    }
    
    // Make an authenticated post request using generic parameters.
    func makeAuthenticatedRequest(host: String = "https://api.cheddarapp.com/",
                                  endpoint: String,
                                  method: String = "GET",
                                  paramString: String?,
                                  token: String) -> URLRequest {
        
        // headers
        var request = URLRequest(url: URL(string: host + endpoint)!)
        request.httpMethod = method
        // Token Header
        request.setValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        
        // parameters
        if let paramString = paramString {
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-type")
            request.httpBody = paramString.data(using: .utf8)
        }
        
        return request
    }
    
    
    // Make an authenticated post request using generic parameters.
    func makeTokenRequest(host: String = "https://api.cheddarapp.com/",
                                      endpoint: String,
                                          code: String) -> URLRequest {
        
        let params = ["grant_type": "authorization_code", "code": code]
        let paramString = encode(parametersToQueryString: params)
        
        let loginString = String(format: "%@:%@", clientID, clientSecret)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
        
        var request = URLRequest(url: URL(string: host + endpoint)!)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-type")
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        request.httpBody = paramString.data(using: .utf8)
        
        return request
    }
    
    // Make an authenticated post request using generic parameters.
    func makePasswordTokenRequest(username: String,
                          password: String) -> URLRequest {
        
        let params = ["grant_type": "password", "username": username, "password": password]
        let paramString = encode(parametersToQueryString: params)
        
        let loginString = String(format: "%@:%@", clientID, clientSecret)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
        
        var request = URLRequest(url: URL(string: "https://api.cheddarapp.com/" + "oauth/token")!)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-type")
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        request.httpBody = paramString.data(using: .utf8)
        
        return request
    }
    
    // Stuff to handle Dates
    func dateFormatter() -> DateFormatter { // 2012-07-02T18:50:53Z
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        // EX: "2012-07-02T18:50:53Z"
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
//        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ" // not sure of the difference between the above and this one.
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }
    
    func nowDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.date(from: "")
        return dateFormatter.string(from: Date(timeIntervalSinceNow: 0))
    }
    
    /***
     *  Parse Decodable
     *
     *  Parses the Decodable stuff into a desired object.
     */
    func parseDecodable<T : Decodable>(completion: @escaping (Result<T, CDKAPIError>) -> Void) -> (Result<Data, CDKAPIError>) -> Void {
        return { result in
            switch result {
            case .success(let data):
                print("parsing data!")
                do {
                    let jsonDecoder = JSONDecoder()
                    let object = try jsonDecoder.decode(T.self, from: data)
                    DispatchQueue.main.async {
                        print("so this should be successful?")
                        completion(.success(object))
                    }
                } catch let decodingError as DecodingError {
                    DispatchQueue.main.async {
                        print("Decoding error was significant")
                        completion(.failure(.decodingError(decodingError)))
                    }
                } catch {
                    fatalError("A totally invalid response from the server")
                }
                
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    /***
     *  Perfom
     *
     *  So much of this api is standard and perform executes the standard stuff.
     */
    func perform(request: URLRequest, completion: @escaping (Result<Data, CDKAPIError>) -> Void) {
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print("We encountered a networking error.")
                completion(.failure(.networkingError(error)))
                return
            }
            
            // yeah let's Guard Let our data and http codes.
            guard let http = response as? HTTPURLResponse, let data = data else {
                print("invalidResponse.")
                completion(.failure(.invalidResponse))
                return
            }
            
            // Switch through what we got.
            switch http.statusCode {
            case 200...299:
                print("200 series result")
                completion(.success(data))
            
            case 300...399:
                print("300 series result")
                let body = String(data: data, encoding: .utf8)
                completion(.failure(.requestError(http.statusCode, body ?? "<no body>")))
                
            case 400...499:
                let body = String(data: data, encoding: .utf8)
                completion(.failure(.requestError(http.statusCode, body ?? "<no body>")))
                
            case 500...599:
                completion(.failure(.serverError))
                
            default:
                fatalError("Unhandled HTTP Code. Ya'll done goofed.")
            }
        }
        task.resume() // it says resume, but really we're just getting started.
    }
}
