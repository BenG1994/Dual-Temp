////
////  ViewController.swift
////  Dual Temp
////
////  Created by Ben Gauger on 10/19/22.
////
///

import UIKit
import CoreLocation
import FlagKit

class WeatherViewController: UIViewController {
    
    
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var temperatureLabelFahrenheit: UILabel!
    @IBOutlet weak var unitsChanged: UIButton!
    @IBOutlet weak var feelsLikeImageView: UIImageView!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var visibilityImageView: UIImageView!
    @IBOutlet weak var visibilityLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var timezoneLabel: UILabel!
    
    @IBOutlet weak var flagImage: UIImageView!
    
    var weatherManager = WeatherManager()
    //    var weather = WeatherModel(conditionId: Int, cityName: String, temperature: Double, feels_like: Double, visibility: Int, humidity: Int, wind: Double, sunrise: Double, sunset: Double, timezone: Int, country: String, latitude: Double, longitude: Double)
    
    //    var weatherManagerFahrenheit = WeatherManagerFahrenheit()
    let locationManager = CLLocationManager()
    //    let locationManagerFahrenheit = CLLocationManager()
    
    let userDefaults = UserDefaults()
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        var flag = Flag(countryCode: "US")!
        
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        
        weatherManager.delegate = self
        searchTextField.delegate = self
        unitsChanged.layer.cornerRadius = 10
        flagImage.image = flag.originalImage
        timezoneLabel.text = "GMT"
        
        //        unitsChanged.setTitle("Metric", for: UIControl.State.normal)
    }
    
    
    @IBAction func locationPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
    @IBAction func unitsPressed(_ sender: UIButton) {
        if (sender.currentTitle == "Imperial") {
            sender.setTitle("Metric", for: UIControl.State.normal)
            
//            func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel){
//                DispatchQueue.main.async {
//                    var newVisibility = weather.visibility/1000
//                    self.feelsLikeLabel.text = "\(weather.feelsLikeString)°C"
//                    self.visibilityLabel.text = "\(newVisibility)km"
//                    self.windSpeedLabel.text = "\(weather.windSpeedString)km/h"
//                }
//                
//            }
        }else {
            sender.setTitle("Imperial", for: UIControl.State.normal)
            
//            func didUpdateWeatherFahrenheit(_weatherManager: WeatherManager, weather: WeatherModelFahrenheit){
//                DispatchQueue.main.async {
//                    var newVisibility = Double(weather.visibilityImperial) * 0.000621371192237
//                    var visibilityStringImperialNew: String {
//                        return String (format: "%.0f", newVisibility)
//                    }
//                    self.feelsLikeLabel.text = "\(weather.feelsLikeStringFahrenheit)°F"
//                    self.windSpeedLabel.text = "\(weather.windSpeedStringImperial)mp/h"
//                    self.visibilityLabel.text = "\(visibilityStringImperialNew)m"
//                }
//            }
        }
        userDefaults.setValue(sender.currentTitle, forKey: "UnitsLabel")
        let units = sender.currentTitle!
        unitsChanged.setTitle(units, for: UIControl.State.normal)
        print (units)
        
        
    }
}



//MARK: - CLLocationManagerDelegate

extension WeatherViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations:[CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
            weatherManager.fetchWeatherFahrenheit(latitude: lat, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print (error)
    }
}

//MARK: - UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate {
    
    
    @IBAction func searchPressed(_ sender: UIButton) {
        print (searchTextField.text!)
        searchTextField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //            let searchName =  searchTextField.text!
        //            let searchNameTextField = searchName.replacingOccurrences(of: " ", with: "+")
        
        //            print (searchNameTextField)
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        }else {
            textField.placeholder = "Search for a place"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textfield: UITextField) {
        if let city = searchTextField.text {
            
            let searchName =  searchTextField.text!
            let searchNameTextField = searchName.replacingOccurrences(of: " ", with: "+")
            
            weatherManager.fetchWeather(cityName: searchNameTextField)
            weatherManager.fetchWeatherFahrenheit(cityName: searchNameTextField)
        }
        searchTextField.text = ""
        
        
    }
    
    func replacesSpaces() -> String {
        let twoWordName = searchTextField.text!.replacingOccurrences(of: " ", with: "_")
        return twoWordName
    }
    
}

//MARK: - WeatherManagerDelegate

extension WeatherViewController: WeatherManagerDelegate {
    
    
    
    func didUpdateWeatherFahrenheit(_weatherManager: WeatherManager, weather: WeatherModelFahrenheit) {
        var newVisibility = Double(weather.visibilityImperial) * 0.000621371192237
        
        var visibilityStringImperialNew: String {
            return String (format: "%.0f", newVisibility)
        }
        
        
        DispatchQueue.main.async {
            self.temperatureLabelFahrenheit
                .text = "\(weather.temperatureStringFahrenheit)°F"
            
        }
        
        if unitsChanged.currentTitle == "Imperial"{
            DispatchQueue.main.async {
                self.feelsLikeLabel.text = "\(weather.feelsLikeStringFahrenheit)°F"
                self.windSpeedLabel.text = "\(weather.windSpeedStringImperial)mp/h"
                self.visibilityLabel.text = "\(visibilityStringImperialNew)m"
                
            }
        }
    }
    
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        var newVisibility = weather.visibility/1000
        let countryCode = weather.country
        let flag = Flag(countryCode: countryCode)!
        
        
        let sunsetTimeStamp = Date(timeIntervalSince1970: weather.sunset)
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeZone = TimeZone(secondsFromGMT: weather.timezone)
        formatter.timeStyle = .short
        let formattedSunsetTime = formatter.string(from: sunsetTimeStamp)
        print (formattedSunsetTime)
        
        let sunriseTimeStamp = Date(timeIntervalSince1970: weather.sunrise)
        let formattedSunriseTime = formatter.string(from: sunriseTimeStamp)
        print (formattedSunriseTime)
        
        
        
        let inputTimeZone = TimeZone(secondsFromGMT: weather.timezone)!
        let timeZoneIdentifier = inputTimeZone.identifier
        
        print(timeZoneIdentifier)
        
        
        
        DispatchQueue.main.async {
            
            
            self.temperatureLabel.text = "\(weather.temperatureString)°C"
            self.timezoneLabel.text = timeZoneIdentifier
            
            self.humidityLabel.text = "\(weather.humidity)%"
            
            self.cityLabel.text = "\(weather.cityName)"
            self.flagImage.image = flag.originalImage
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.sunsetLabel.text = "\(formattedSunsetTime)"
            self.sunriseLabel.text = "\(formattedSunriseTime)"
        }
        
        if unitsChanged.currentTitle == "Metric"{
            DispatchQueue.main.async {
                self.feelsLikeLabel.text = "\(weather.feelsLikeString)°C"
                self.feelsLikeImageView.image = UIImage(systemName: weather.conditionName)
                self.visibilityLabel.text = "\(newVisibility)km"
                self.visibilityImageView.image = UIImage(systemName: weather.visibilityStrength)
                
                self.windSpeedLabel.text = "\(weather.windSpeedString)km/h"
                
            }
        }
        
    }
    
    func didFailWithError(error: Error) {
        print (error)
    }
}
