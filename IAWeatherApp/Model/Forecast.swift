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
    var day: String?
    
    init(jsonObject: [String:Any]) {
        if let dateString = jsonObject["Date"] as? String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
            
            let datePrinter = DateFormatter()
            datePrinter.dateFormat = "EEEE"
            
            if let date = dateFormatter.date(from: dateString) {
                day = datePrinter.string(from: date)
            }
        }
        
        if let dayObject = jsonObject["Day"] as? [String: Any] {
            self.condition = dayObject["IconPhrase"] as? String
        }
        
        if let temperatureObject = jsonObject["Temperature"] as? [String: Any] {
            
            if let maximumObject = temperatureObject["Maximum"] as? [String: Any] {
                self.highTemperature = maximumObject["Value"] as? Int
            }
            
            if let minimumObject = temperatureObject["Minimum"] as? [String: Any] {
                self.lowTemperature = minimumObject["Value"] as? Int
            }
        }
    }
}
