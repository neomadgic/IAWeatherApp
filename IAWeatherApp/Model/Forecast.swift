//
//  Forecast.swift
//  IAWeatherApp
//
//  Created by Vu Dang on 5/19/21.
//

import Foundation

struct Forecast {
    
    var condition: String?
    var highTemperature: Int?
    var lowTemperature: Int?
    
    init(jsonObject: [String:Any]) {
        if let dayObject = jsonObject["Day"] as? [String: Any] {
            self.condition = dayObject["IconPhrase"] as? String
        }
        
        if let temperatureObject = jsonObject["Temperature"] as? [String: Any] {
            
            if let maximumObject = temperatureObject["Maximum"] as? [String: Any] {
                self.highTemperature = maximumObject["Value"] as? Int
            }
            
            if let minimumObject = temperatureObject["Maximum"] as? [String: Any] {
                self.lowTemperature = minimumObject["Value"] as? Int
            }
        }
    }
}
