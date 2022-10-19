////
////  WeatherData.swift
////  Dual Temp
////
////  Created by Ben Gauger on 10/19/22.
////
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
    let wind: Wind
}

struct Main: Codable {
    let temp: Double
    let pressure: Int
}

struct Weather: Codable {
    let id: Int
}

struct Wind: Codable {
    let speed: Double
}







//import Foundation
//
//
//struct WeatherData: Codable {
//    let name: String
//    let main: Main
//    let weather: [Weather]
//    let wind: Wind
//
//}
//
//struct Main: Codable {
//    let temp: Double
//    let feels_like: Double
//    let temp_min: Double
//    let temp_max: Double
//    let humidity: Double
//}
//
//struct Visibility: Codable {
//    let visibility: Double
//}
//
//struct Wind: Codable {
//    let speed: Double
//}
//
//struct Weather: Codable {
//    let id: Int
//}
