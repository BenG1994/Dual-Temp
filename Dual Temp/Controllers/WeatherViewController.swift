////
////  ViewController.swift
////  Dual Temp
////
////  Created by Ben Gauger on 10/19/22.
////
///

import UIKit
import CoreLocation

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
    
    
    
    var weatherManager = WeatherManager()
    //    var weatherManagerFahrenheit = WeatherManagerFahrenheit()
    let locationManager = CLLocationManager()
    //    let locationManagerFahrenheit = CLLocationManager()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        
        weatherManager.delegate = self
        searchTextField.delegate = self
        
        //        unitsChanged.setTitle("Metric", for: UIControl.State.normal)
    }
    
    
    @IBAction func locationPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
    @IBAction func unitsPressed(_ sender: UIButton) {
        if (sender.currentTitle == "Imperial") {
            sender.setTitle("Metric", for: UIControl.State.normal)
        }else {
            sender.setTitle("Imperial", for: UIControl.State.normal)
        }
        let units = sender.currentTitle!
        unitsChanged.setTitle(units, for: UIControl.State.normal)
        print (units)
        

        self.viewDidLoad()
        
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
    
//    let date = Date(timeIntervalSince1970: unixtimeInterval)
//    let dateFormatter = DateFormatter()
//    dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
//    dateFormatter.locale = NSLocale.current
//    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm" //Specify your format that you want
//    let strDate = dateFormatter.string(from: date)
//
    
    
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
    
    
    print (newVisibility)
    DispatchQueue.main.async {
        self.temperatureLabel.text = "\(weather.temperatureString)°C"
        
        
        self.cityLabel.text = weather.cityName
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
            self.humidityLabel.text = "\(weather.humidity)%"
            self.windSpeedLabel.text = "\(weather.windSpeedString)km/h"
            
        }
    }
    
}

func didFailWithError(error: Error) {
    print (error)
}
}
