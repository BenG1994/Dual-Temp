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
    
    
    var temperatureString: String {
        return String (format: "%.1f", temperature)
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







//import Foundation
//
//
//struct WeatherModel {
//
//    let conditionId: Int
//    let cityName: String
//    let temperature: Double
////    let temperatureCelsius: Double
////    let temperatureFahrenheit: Double
//
//    var temperatureString: String {
//        return String (format: "0.1f", temperature)
//    }
//
//
////    var temperatureStringCelsius: String {
////        return String (format: "%.1f", temperatureCelsius)
////    }
////
////    var temperatureStringFahrenheit: String {
////        return String (format: "%.1f", temperatureFahrenheit)
////
////    }
//
//    var conditionName: String {
//        switch conditionId {
//        case 200...232:
//            return "cloud.bolt"
//
//        case 300...321:
//            return "cloud.drizzle"
//
//        case 500...531:
//            return "cloud.rain"
//
//        case 600...622:
//            return "cloud.snow"
//        case 701...781:
//            return "cloud.fog"
//        case 800:
//            return "sun.max"
//        case 801...804:
//            return "cloud.bolt"
//
//        default:
//            return "cloud"
//
//
//        }
//    }
//}
