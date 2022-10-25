////
////  WeatherModel.swift
////  Dual Temp
////
////  Created by Ben Gauger on 10/19/22.
////
//


import Foundation
import UIKit

struct WeatherModel {
    
    let conditionId: Int
    let cityName: String
    let temperature: Double
    let feels_like: Double
    let visibility: Int
    let humidity: Int
    let wind: Double
    let sunrise: Double
    let sunset: Double
    let timezone: Int
    let country: String
    let latitude: Double
    let longitude: Double
    
    func replaceSpaces(cityName: String) -> String {
        let correctCityName = cityName.replacingOccurrences(of: " ", with: "+")
        return correctCityName
    }
    
    var temperatureString: String {
        return String (format: "%.0f", temperature)
    }
    
    var feelsLikeString: String {
        return String (format: "%.0f", feels_like)
    }
    
    var visibilityString: String {
        return String (format: "%.0f", visibility)
    }
    
    var humidityString: String {
        return String (format: "%.0f", humidity)
    }
    
    var windSpeedString: String {
        return String (format: "%.0f", wind)
    }
    
//    var rainString: String {
//        return String (format: "%.0f", rain)
//    }
    
    var sunsetString: String {
        return String (format: "%.0f", sunset)
    }
    
    var sunriseString: String {
        return String (format: "%.0f", sunrise)
    }
    
    var timezoneString: String {
        return String (format: "%.0f", timezone)
    }
    
    var conditionName: String {
        switch conditionId {
            case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
            
        default:
            return "cloud"
            
            
            
        }
    }
    
   
    
    
    
    var visibilityStrength: String {
        switch visibility {
        case 0...1000:
            return "smoke"
        case 2000...4000:
            return "cloud"
        case 5000...7000:
            return "cloud.sun"
        case 8000...9000:
            return "sun.haze"
        case 10000:
            return "sun.max"
            
        default:
            return "sun.max"
        }
    }
    
    var temperatureColorCelsius: UIColor {
        switch temperature {
        case ...(-17.5):
            return UIColor.systemPurple
        case -17.6...0.5:
            return UIColor.systemBlue
        case 0.6...9.5:
            return UIColor.systemGreen
        case 9.6...24.5:
            return UIColor.systemYellow
        case 24.6...29.5:
            return  UIColor.orange
        case 29.6...35.5:
            return UIColor.systemRed
        case 35.6...:
            return UIColor.systemBrown
        default:
            return UIColor.black
        }
    }
    
//    var humidityStrength: String {
//        switch humidity {
//        case 0...20:
//            return "
//        }
//    }
    
}


//MARK: - Fahrenheit


struct WeatherModelFahrenheit {
    
    let conditionId: Int
   let cityName: String
    let temperatureFahrenheit: Double
    let feels_likeFahrenheit: Double
    let visibilityImperial: Int
    let windImperial: Double

    
    var temperatureStringFahrenheit: String {
        return String (format: "%.0f", temperatureFahrenheit)
    }
    
    var feelsLikeStringFahrenheit: String {
        return String (format: "%.0f", feels_likeFahrenheit)
    }
    
    var visibilityStringImperial: String {
        return String (format: "%.0f", visibilityImperial)
    }

    
    var windSpeedStringImperial: String {
        return String (format: "%.0f", windImperial)
    }
    
    
    var conditionName: String {
        switch conditionId {
            case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
            
        default:
            return "cloud"
            
            
            
        }
    }
    
    var temperatureColorFahrenheit: UIColor {
        switch temperatureFahrenheit {
        case ...0.5:
            return UIColor.systemPurple
        case 0.6...32.5:
            return UIColor.systemBlue
        case 32.6...49.5:
            return UIColor.systemGreen
        case 49.6...75.5:
            return UIColor.systemYellow
        case 75.6...85.5:
            return  UIColor.orange
        case 85.6...95.5:
            return UIColor.systemRed
        case 95.6...:
            return UIColor.systemBrown
        default:
            return UIColor.black
        }
    }
}
