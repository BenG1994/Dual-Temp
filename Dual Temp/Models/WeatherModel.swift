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
    
//    var roundedTemperature: Double {
//        return ceil(temperature)
//    }
    
    var temperatureString: String {
        
//        var roundNum = temperature.rounded(.toNearestOrAwayFromZero)
        
        
        return String (format: "%.0f", temperature)
//        round before turning into string. maybe here?
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
            return "cloud"
            
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
        case ...(-31.94):
            return UIColor.white
        case (-31.93)...(-17.59):
            return UIColor.systemPurple
        case -17.6...0.59:
            return UIColor.systemBlue
        case 0.6...9.59:
            return UIColor.systemGreen
        case 9.6...24.59:
            return UIColor.systemYellow
        case 24.6...29.59:
            return  UIColor.orange
        case 29.6...35.59:
            return UIColor.systemRed
        case 35.6...49.59:
            return UIColor.systemBrown
        case 49.6...:
            return UIColor.black

        default:
            return UIColor.black
        }
    }
    
    //MARK: - TimeZone Switch

    var timeZoneIndentifier: String {
        switch timezone{
        case ...(-39600):
            return "Pacific/Midway"
        case ...(-36000):
            return "Pacific/Honolulu"
        case ...(-34200):
            return "Pacific/Marquesas"
        case ...(-32400):
            return "America/Anchorage"
        case ...(-28800):
            return "America/Vancouver"
        case ...(-25200):
            return "America/Denver"
        case ...(-21600):
            return "America/Chicago"
        case ...(-18000):
            return "America/Bogota"
        case ...(-14400):
            return "Atlantic/Bermuda"
        case ...(-10800):
            return "America/Santiago"
        case ...(-7200):
            return "Atlantic/Noronha"
        case ...(-3600):
            return "Atlantic/Azores"
        case ...0:
            return "Europe/London"
        case ...3600:
            return "Europe/Madrid"
        case ...7200:
            return "Europe/Riga"
        case ...10800:
            return "Europe/Istanbul"
        case ...12600:
            return "Asia/Tehran"
        case ...14400:
            return "Asia/Baku"
        case ...16200:
            return "Asia/Kabul"
        case ...18000:
            return "Asia/Dushanbe"
        case ...19800:
            return "Asia/Colombo"
        case ...20700:
            return "Asia/Kathmandu"
        case ...21600:
            return "Asia/Urumqi"
        case ...23400:
            return "Asia/Yangon"
        case ...25200:
            return "Asia/Bangkok"
        case ...28800:
            return "Asia/Shanghai"
        case ...31500:
            return "Australia/Eucla"
        case ...32400:
            return "Asia/Seoul"
        case ...34200:
            return "Australia/Darwin"
        case ...36000:
            return "Australia/Brisbane"
        case ...37800:
            return "Australia/Adelaide"
        case ...39600:
            return "Australia/Sydney"
        case ...43200:
            return "Pacific/Fiji"
        case ...46800:
            return "Pacific/Auckland"
        case ...49500:
            return "Pacific/Chatham"
        case ...50400:
            return "Pacific/Kiritimati"
        
        default:
            return "Europe/London"
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
        case ...(-25.5):
            return UIColor.white
        case (-24.49)...0.59:
            return UIColor.systemPurple
        case 0.6...32.59:
            return UIColor.systemBlue
        case 32.6...49.59:
            return UIColor.systemGreen
        case 49.6...75.59:
            return UIColor.systemYellow
        case 75.6...85.59:
            return  UIColor.orange
        case 85.6...95.59:
            return UIColor.systemRed
        case 95.6...120.59:
            return UIColor.systemBrown
        case 120.6...:
            return UIColor.black

        default:
            return UIColor.black
        }
    }
    
}

//MARK: - Metric

struct WeatherModelMetric{
    let feelsLikeCelsius: Double
    let visibilityMetric: Int
    let windSpeedMetric: Double
    
    
    var feelsLikeString: String {
        return String (format: "%.0f", feelsLikeCelsius)
    }
    
    var visibilityString: String {
        return String (format: "%.0f", visibilityMetric)
    }
    
    
    var windSpeedString: String {
        return String (format: "%.0f", windSpeedMetric)
    }
}

//MARK: - Imperial

struct WeatherModelImperial{
    let feelsLikeFahrenheit: Double
    let visibilityImperial: Int
    let windSpeedImperial: Double
    
    
    var feelsLikeStringFahrenheit: String {
        return String (format: "%.0f", feelsLikeFahrenheit)
    }
    
    var visibilityStringImperial: String {
        return String (format: "%.0f", visibilityImperial)
    }
    
    
    var windSpeedStringImperial: String {
        return String (format: "%.0f", windSpeedImperial)
    }
}


