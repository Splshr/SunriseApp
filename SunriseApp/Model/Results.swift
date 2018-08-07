//
//  CurentSunriseSunset.swift
//  Sunset
//
//  Created by Dmytro Khrystych on 8/3/18.
//  Copyright © 2018 WonderDev. All rights reserved.
//
//    "results":{
//        "sunrise":"5:25:32 AM",
//        "sunset":"7:22:08 PM",
//        "solar_noon":"12:23:50 PM",
//        "day_length":"13:56:36",
//        ...
//    },
//    "status":"OK"
//}
//

import Foundation

class Results {
    
    let sunrise : String?
    let sunset : String?
    let solar_noon : String?
    let day_length: String?
    
    struct resultsKeys {
        
        static let sunrise = "sunrise"
        static let sunset = "sunset"
        static let solar_noon = "solar_noon"
        static let day_lenght = "day_length"
    }
    
    init(resultsDictionary: [String : Any]) {
        
        sunrise = resultsDictionary[resultsKeys.sunrise] as? String
        sunset = resultsDictionary[resultsKeys.sunset] as? String
        solar_noon = resultsDictionary[resultsKeys.solar_noon] as? String
        day_length = resultsDictionary[resultsKeys.day_lenght] as? String
    }
}
