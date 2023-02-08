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
import WidgetKit

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
    
    let locationManager = CLLocationManager()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let userDefaults = UserDefaults.standard
    let textUserDefaults = UserDefaults(suiteName: "group.DualTemp")!

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        

        let flag = Flag(countryCode: "US")!
    
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        print(locationManager.location)
        locationManager.stopUpdatingLocation()
//        cityLabel.text = "..."
//        temperatureLabel.text = "21°C"
//        temperatureLabelFahrenheit.text = "21°F"
        
        unitsChanged.setTitle("Imperial", for: .normal)
    
//        unitsChanged.setTitle("Imperial", for: UIControl.State.normal)
        
        weatherManager.delegate = self
        searchTextField.delegate = self
        unitsChanged.layer.cornerRadius = 10
        flagImage.image = flag.originalImage
//        flagImage.image = userDefaults.object(forKey: "Flag") as? UIImage
        timezoneLabel.text = "GMT"
        
        
//
        


    }
    override func viewWillAppear(_ animated: Bool) {
        
        
        DispatchQueue.main.async {
            
            if self.userDefaults.string(forKey: "SearchedCity") != nil {
                self.cityLabel.text = self.userDefaults.string(forKey: "SearchedCity")
            }else {
                self.cityLabel.text = "..."
            }
            
            if self.userDefaults.value(forKey: "UnitsLabel") != nil {
                self.unitsChanged.setTitle(self.userDefaults.value(forKey: "UnitsLabel") as? String, for: .normal)
            }else {
                self.unitsChanged.setTitle("Imperial", for: .normal)
            }
            
            if self.userDefaults.string(forKey: "CTemp") != nil {
//                let roundedTemp = self.userDefaults.string(forKey: "CTemp")
//
//                if roundedTemp == "-0°C"{
//                    roundedTemp?.replacingOccurrences(of: "-0°C", with: "0°C")
//                }
//
//                self.temperatureLabel.text = roundedTemp
                self.temperatureLabel.text = self.userDefaults.string(forKey: "CTemp")
        
            }else {
                self.temperatureLabel.text = "21°C"
            }
            
            if self.userDefaults.string(forKey: "FTemp") != nil {
                self.temperatureLabelFahrenheit.text = self.userDefaults.string(forKey: "FTemp")
            }else {
                self.temperatureLabelFahrenheit.text = "21°F"
            }
            
            
            if self.userDefaults.value(forKey: "WeatherIcon") != nil {
                self.conditionImageView.image = UIImage(systemName: self.userDefaults.value(forKey: "WeatherIcon") as! String)
            }else{
                self.conditionImageView.image = UIImage(systemName: "sun")
            }
            
            WidgetCenter.shared.reloadAllTimelines()
        }
        //            unitsChanged.setTitle(userDefaults.value(forKey: "UnitsLabel") as? String, for: .normal)
        //            cityLabel.text = self.userDefaults.string(forKey: "SearchedCity")
        //            temperatureLabel.text = self.userDefaults.string(forKey: "CTemp")
        //            temperatureLabelFahrenheit.text = self.userDefaults.string(forKey: "FTemp")
    }

   
    
    @IBAction func locationPressed(_ sender: UIButton) {
        locationManager.startUpdatingLocation()
        
    }
    
    
    
  
    
    
    @IBAction func buttonForCodes(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: K.segueIdentifier, sender: self)
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
//            textUserDefaults?.set(weatherManager.fetchWeather(latitude: lat, longitude: lon), forKey: "CTemp")
//            print("\(textUserDefaults?.value(forKey: "CTemp")) current location)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print (error)
    }
}

//MARK: - UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate {
    
    
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        <#code#>
//    }
    
    
    @IBAction func searchPressed(_ sender: UIButton) {
        print (searchTextField.text!)
        searchTextField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
//    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
//        if textField.text != "" {
//            return true
//        }else {
//            textField.placeholder = "Search for a place"
//            return false
//        }
//    }
    
    func textFieldDidEndEditing(_ textfield: UITextField) {
        if searchTextField.text != nil {
            
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
    func didFailWithError(error: Error) {
        print (error)
    }
    
    @IBAction func unitsPressed(_ sender: UIButton) {
        if sender.currentTitle == "Imperial" {
            sender.setTitle("Metric", for: UIControl.State.normal)
            cityLabel.text = "Search again"
            
          
    
    
            
            //MARK: - begin shit
//            func didUpdateWeatherMetric(_ weatherManager: WeatherManager, weather: WeatherModelMetric) {
//                DispatchQueue.main.async {
//                    let newVisibility = weather.visibilityMetric/1000
//                        self.feelsLikeLabel.text = "\(weather.feelsLikeString)°C"
//                        self.visibilityLabel.text = "\(newVisibility)km"
//                        self.windSpeedLabel.text = "\(weather.windSpeedString)km/h"
//
//
//                }
//
//            }
            
            //MARK: - end shit
        }else {
            sender.setTitle("Imperial", for: UIControl.State.normal)
            cityLabel.text = "Search again"
//            func didUpdateWeatherImperial(_weatherManager: WeatherManager, weather: WeatherModelImperial) {
//                DispatchQueue.main.async {
//                    let newVisibility = Double(weather.visibilityImperial) * 0.000621371192237
//
//                    var visibilityStringImperialNew: String {
//                        return String (format: "%.0f", newVisibility)
//                    }
//
//
//                        self.feelsLikeLabel.text = "\(weather.feelsLikeStringFahrenheit)°F"
//                        self.windSpeedLabel.text = "\(weather.windSpeedStringImperial)mp/h"
//                        self.visibilityLabel.text = "\(visibilityStringImperialNew)m"
//
//
//                }
//
//            }
            
        }
        
        
        
        
        
        userDefaults.setValue(sender.currentTitle!, forKey: "UnitsLabel")
//        let units = sender.currentTitle!
//        unitsChanged.setTitle(units, for: UIControl.State.normal)
        
        
    }
    
    
    func didUpdateWeatherFahrenheit(_weatherManager: WeatherManager, weather: WeatherModelFahrenheit) {
        
        let newVisibility = Double(weather.visibilityImperial) * 0.000621371192237
        
        var visibilityStringImperialNew: String {
            return String (format: "%.0f", newVisibility)
        }
        
        
        DispatchQueue.main.async {
            self.temperatureLabelFahrenheit
                .text = "\(weather.temperatureStringFahrenheit)°F"
            
            self.userDefaults.set("\(weather.temperatureStringFahrenheit)°F", forKey: "FTemp")
            
            self.textUserDefaults.set("\(weather.temperatureStringFahrenheit)°F", forKey: "FTempWidget")
            print("\(self.textUserDefaults.string(forKey: "FTempWidget")!) text user defaults for FTemp")
            WidgetCenter.shared.reloadAllTimelines()
            
            
            
            print(self.userDefaults.string(forKey: "FTemp")!)
            
            self.temperatureLabelFahrenheit.textColor = weather.temperatureColorFahrenheit
            
        }
        
        DispatchQueue.main.async {
            if self.unitsChanged.currentTitle == "Imperial"{
                self.feelsLikeLabel.text = "\(weather.feelsLikeStringFahrenheit)°F"
                self.windSpeedLabel.text = "\(weather.windSpeedStringImperial)mp/h"
                self.visibilityLabel.text = "\(visibilityStringImperialNew)mi"
                
            }
        }
    }
    
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        let newVisibility = weather.visibility/1000
        let countryCode = weather.country
        let flag = Flag(countryCode: countryCode)!
        
//        let flagString = "\(flag)"
        
//        self.userDefaults.set(flag, forKey: "Flag")
//        print(self.userDefaults.object(forKey: "Flag")!)
        
        
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
        
        //MARK: - local time
        
        
            let d = Date()
            var f = Date.FormatStyle()
            .hour(.defaultDigits(amPM: .abbreviated))
                    .minute(.twoDigits)
//            print(d.formatted(f))
            f.timeZone = TimeZone(identifier: weather.timeZoneIndentifier)!
            print(d.formatted(f))
        

      
        
        
        
        
        let localTime = d.formatted(f)
//        print("\(hour):\(minute)")
        
        
        
    
//        print  (localTime)
        
        
        
        
//        let localTime = weather.timezone
//        formatter.timeZone = TimeZone(secondsFromGMT: weather.timezone)
//        formatter.timeStyle = .short
//        formatter.dateStyle = .none
//        let localTimeFormatted = formatter.string(from: localTime)
       
        
        
        
        
        //MARK: - end local time
        
        
        DispatchQueue.main.async {
            
//            self.userDefaults.set("\(weather.cityName)", forKey: "searchedCity")
            self.userDefaults.set("\(weather.cityName)", forKey: "SearchedCity")
            self.textUserDefaults.set("\(weather.cityName)", forKey: "SearchedCityWidget")
//            WidgetCenter.shared.reloadAllTimelines()
            print(self.userDefaults.string(forKey: "SearchedCity")!)
            print("\(self.textUserDefaults.string(forKey: "SearchedCityWidget")!) text user defaults for city name")
    
            
            self.userDefaults.set("\(weather.temperatureString)°C", forKey: "CTemp")
            self.textUserDefaults.set("\(weather.temperatureString)°C", forKey: "CTempWidget")
            print("\(self.textUserDefaults.string(forKey: "CTempWidget")!) text user defaults for CTemp")
//            print(self.userDefaults.string(forKey: "CTemp")!)
            WidgetCenter.shared.reloadAllTimelines()
           
            self.temperatureLabel.text = "\(weather.temperatureString)°C"
            self.temperatureLabel.textColor = weather.temperatureColorCelsius
            
            
            self.timezoneLabel.text = "\(timeZoneIdentifier) \n \(localTime)"
            
            self.humidityLabel.text = "\(weather.humidity)%"
            
            self.cityLabel.text = "\(weather.cityName)"
            
            
            
            
            self.flagImage.image = flag.originalImage
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            
            //MARK: - conditionID
            print("\(weather.conditionName) condition for Widget")
            
            self.userDefaults.set(weather.conditionName, forKey: "WeatherIcon")
            print("\(self.userDefaults.value(forKey: "WeatherIcon")!) condition for WeatherIcon shit")
            
            self.textUserDefaults.set(weather.conditionName, forKey: "WidgetIcon")
            print("\(self.textUserDefaults.value(forKey: "WidgetIcon")!) condition for WidgetIcon shit")
//            WidgetCenter.shared.reloadAllTimelines()
            
            self.sunsetLabel.text = "\(formattedSunsetTime)"
            self.sunriseLabel.text = "\(formattedSunriseTime)"
            
        }
        
        
        DispatchQueue.main.async {
            if self.unitsChanged.currentTitle == "Metric"{
                self.feelsLikeLabel.text = "\(weather.feelsLikeString)°C"
                self.feelsLikeImageView.image = UIImage(systemName: weather.conditionName)
                self.visibilityLabel.text = "\(newVisibility)km"
                self.visibilityImageView.image = UIImage(systemName: weather.visibilityStrength)
                self.windSpeedLabel.text = "\(weather.windSpeedString)km/h"
                
            }
        }

        
    
        func didFailWithError(error: Error) {
            print (error)
        }
        
        
    }
    
   
    
}


//extension WeatherViewController: UISearchBarDelegate{
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchBar.text?.count == 0 {
//
//            DispatchQueue.main.async {
//                searchBar.resignFirstResponder()
//
//            }
//        }
//    }
//}

//extension WeatherViewController{
//    //    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//    //        self.searchTextField.endEditing(true)
//    //    }
//
//
//
//}



