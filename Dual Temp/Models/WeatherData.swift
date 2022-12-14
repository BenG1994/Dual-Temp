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
    let visibility: Int
    let sys: Sys
    let timezone: Int
    let coord: Coord
}

struct Main: Codable {
    let temp: Double
    let pressure: Int
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let humidity: Int
}

struct Weather: Codable {
    let id: Int
}

struct Wind: Codable {
    let speed: Double
}

struct Sys: Codable {
    let sunrise: Double
    let sunset: Double
    let country: String
}

struct Coord: Codable {
    let lon: Double
    let lat: Double
}
