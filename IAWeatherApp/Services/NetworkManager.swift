//
//  NetworkManager.swift
//  IAWeatherApp
//
//  Created by Vu Dang on 5/19/21.
//

import Foundation

class NetworkManager {
    
    static func fetchLocationID(zipCode: String, completionHandler: @escaping (Location, Error?) -> Void) {
        var location = Location()
        if let url = URL(string: "http://dataservice.accuweather.com/locations/v1/postalcodes/search?apikey=\(Key.API_KEY)&q=\(zipCode)") {
            
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data else {
                    completionHandler(location, error)
                    return
                }
                
                if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                    location = Location(jsonObject: json[0])
                }
                
                completionHandler(location, error)
            }
            task.resume()
        }
    }
    
    static func fetchWeather(locationKey: String, completionHandler: @escaping ([Forecast], Error?) -> Void) {
        var forecasts = [Forecast]()
        if let url = URL(string:
                            "http://dataservice.accuweather.com/forecasts/v1/daily/5day/\(locationKey)?apikey=\(Key.API_KEY)") {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data else {
                    completionHandler(forecasts, error)
                    return
                }
                
                if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    if let forecastObjects = json["DailyForecasts"] as? [[String: Any]] {
                        for object in forecastObjects {
                            let forecast = Forecast(jsonObject: object)
                            forecasts.append(forecast)
                        }
                    }
                    completionHandler(forecasts, error)
                }
                
            }
            task.resume()
        }
    }
}
