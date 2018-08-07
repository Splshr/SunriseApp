//
//  Network.swift
//  Sunset
//
//  Created by Dmytro Khrystych on 8/3/18.
//  Copyright © 2018 WonderDev. All rights reserved.
//
//

import Foundation

class Network {
    
    lazy var configuration : URLSessionConfiguration = URLSessionConfiguration.default
    
    lazy var session: URLSession = URLSession(configuration: self.configuration)
    
    let url: URL
    
    init(url: URL) {
        self.url = url
    }
    
    typealias JSONDictionary = (([String : Any]?) -> Void)
    
    func downloadJSONFromURL (_ completion: @escaping JSONDictionary) {
        
        let request = URLRequest(url: self.url)
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            
            if error == nil {
                if let httpResponse = response as? HTTPURLResponse {
                    
                    switch httpResponse.statusCode {
                        
                    case 200:
                        //successful response
                        if let data = data {
                            
                            do {
                                let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                                completion(jsonDictionary as? [String : Any])
                                
                            } catch let error as NSError {
                                print("Error with processing JSON data: \(error.localizedDescription)")
                            }
                        }
                        
                    default:
                        print("HTTP Response Code: \(httpResponse.statusCode)")
                    }
                }
            } else {
                print("Error: \(error?.localizedDescription)")
            }
        }
        dataTask.resume()
    }
}

