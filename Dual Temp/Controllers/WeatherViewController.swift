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
    }
    
    
    @IBAction func locationPressed(_ sender: UIButton) {
        locationManager.requestLocation()
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
        DispatchQueue.main.async {
            self.temperatureLabelFahrenheit
                .text = "\(weather.temperatureStringFahrenheit)°F"
        }
    }
    
        func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
            DispatchQueue.main.async {
                self.temperatureLabel.text = "\(weather.temperatureString)°C"
              
                self.cityLabel.text = weather.cityName
                self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            }
        }
        
        func didFailWithError(error: Error) {
            print (error)
        }
    }

