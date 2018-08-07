//
//  Sunrise_Sunset.swift
//  Sunset
//
//  Created by Dmytro Khrystych on 8/3/18.
//  Copyright © 2018 WonderDev. All rights reserved.
//
//https://api.sunrise-sunset.org/json?lat=36.7201600&lng=-4.4203400&date=today
//

import Foundation
import CoreLocation

class Model {
    
    let sunriseBaseUrl : URL?
    
    init() {
        sunriseBaseUrl = URL(string: "https://api.sunrise-sunset.org/json?")
    }
    
    func forecast (withLocation location: CLLocationCoordinate2D, completion: @escaping (Results?) -> Void) {
        
        if let sunriseURL = URL(string: "\(sunriseBaseUrl!)lat=\(location.latitude)&lng=\(location.longitude)&date=today") {
            
            let network = Network(url: sunriseURL)
            network.downloadJSONFromURL { (jsonDictionary) in
                
                if let currentSunTimeDict = jsonDictionary?["results"] as? [String : Any] {
                    
                    let currentSunTime = Results(resultsDictionary: currentSunTimeDict)
                    completion(currentSunTime)
                } else {
                    completion(nil)
                }
            }
        }
    }
}

