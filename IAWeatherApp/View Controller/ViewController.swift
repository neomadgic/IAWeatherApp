//
//  ViewController.swift
//  IAWeatherApp
//
//  Created by Vu Dang on 5/19/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var zipCodeTextField: UITextField!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var location: Location?
    var forecasts = [Forecast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "ForecastTableViewCell", bundle: nil), forCellReuseIdentifier: "ForecastTableViewCell")
    }
    
    func updateDisplay() {
        if forecasts.isEmpty {
            descriptionLabel.text = "Sorry! We were unable to pull up any forecasts!"
            tableView.isHidden = true
        } else {
            
            if let location = location {
                descriptionLabel.text = location.formattedCityState
            } else {
                descriptionLabel.text = ""
            }
            tableView.isHidden = false
            tableView.reloadData()
        }
        
        descriptionLabel.isHidden = false
    }

    @IBAction func getForecast(_ sender: UIButton) {
        location = nil
        forecasts.removeAll()
        zipCodeTextField.resignFirstResponder()
        descriptionLabel.isHidden = true
        tableView.isHidden = true
        guard let zipCode = zipCodeTextField.text, zipCode.count == 5, zipCode.isNumberOnly() == true else {
            updateDisplay()
            return
        }
        
        NetworkManager.fetchLocationID(zipCode: zipCode) { (location, error) in
            if error == nil, let locationKey = location.locationKey {
                self.location = location
                
                NetworkManager.fetchWeather(locationKey: locationKey) { (forecasts, error) in
                    self.forecasts = forecasts
                    
                    DispatchQueue.main.async {
                        self.updateDisplay()
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.updateDisplay()
                }
            }
        }
    }
    
    // MARK: - UITableView Delegates
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastTableViewCell") as? ForecastTableViewCell else {
            return UITableViewCell()
        }
        cell.setUpCell(forecast: forecasts[indexPath.row])
        return cell
    }
}

