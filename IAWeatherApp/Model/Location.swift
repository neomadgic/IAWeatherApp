//
//  Location.swift
//  IAWeatherApp
//
//  Created by Vu Dang on 5/19/21.
//

import Foundation

struct Location {
    
    var locationKey: String?
    var city: String?
    var stateFullName: String?
    var stateAbbreviation: String?
    
    var formattedCityState: String {
        var formatted = city ?? ""
        if formatted.isEmpty {
            formatted = stateAbbreviation ?? ""
        } else {
            if let stateAbbreviation = stateAbbreviation {
                formatted.append(", \(stateAbbreviation)")
            }
        }
        
        return formatted
    }
    
    init() {
        
    }
    
    init(jsonObject: [String:Any]) {
        self.locationKey = jsonObject["Key"] as? String
        self.city = jsonObject["EnglishName"] as? String
        
        if let administrativeAreaObject = jsonObject["AdministrativeArea"] as? [String: Any] {
            self.stateFullName = administrativeAreaObject["EnglishName"] as? String
            self.stateAbbreviation = administrativeAreaObject["ID"] as? String
        }
    }
}
