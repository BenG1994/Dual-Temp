////
////  WeatherModel.swift
////  Dual Temp
////
////  Created by Ben Gauger on 10/19/22.
////
//


import Foundation

struct WeatherModel {
    
    let conditionId: Int
    let cityName: String
    let temperature: Double
    let feels_like: Double
    let visibility: Int
    let humidity: Int
    
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
            return "cloud"
        case 2000...4000:
            return "cloud.sun"
        case 5000...7000:
            return "sun.haze"
        case 8000...9000:
            return "sun.dust"
        case 10000:
            return "sun.max"
            
        default:
            return "sun.max"
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
    

    
    var temperatureStringFahrenheit: String {
        return String (format: "%.0f", temperatureFahrenheit)
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
}
