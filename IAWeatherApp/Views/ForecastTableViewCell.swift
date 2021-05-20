//
//  ForecastTableViewCell.swift
//  IAWeatherApp
//
//  Created by Vu Dang on 5/19/21.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var highLabel: UILabel!
    @IBOutlet weak var lowLabel: UILabel!

    func setUpCell(forecast: Forecast) {
        conditionLabel.text = forecast.condition ?? ""
        if let day = forecast.day {
            dayLabel.text = day
        }
        
        if let high = forecast.highTemperature, let low = forecast.lowTemperature {
            highLabel.text = "High: \(high)°"
            lowLabel.text = "Low: \(low)°"
            
            if high > 70 {
                contentView.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
            } else {
                contentView.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
            }
        } else {
            highLabel.text = "High: "
            lowLabel.text = "Low: "
            contentView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        }
    }
    
}
