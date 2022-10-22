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
}

//MARK: - bottom section

// feels like
//temp min
//temp max
//humidity
//wind speed
//precipition
//rain 1hr
//snow 1hr



//
//
//"coord": {
//   "lon": -122.4194,
//   "lat": 37.7749
// },
// "weather": [
//   {
//     "id": 804,
//     "main": "Clouds",
//     "description": "overcast clouds",
//     "icon": "04d"
//   }
// ],
// "base": "stations",
// "main": {
//   "temp": 15.31,
//   "feels_like": 15.14,
//   "temp_min": 11.96,
//   "temp_max": 21.58,
//   "pressure": 1013,
//   "humidity": 86
// },
// "visibility": 10000,
// "wind": {
//   "speed": 4.12,
//   "deg": 320
// },
// "clouds": {
//   "all": 100
// },
// "dt": 1666376045,
// "sys": {
//   "type": 2,
//   "id": 2016474,
//   "country": "US",
//   "sunrise": 1666362227,
//   "sunset": 1666401867
// },
// "timezone": -25200,
// "id": 5391959,
// "name": "San Francisco",
// "cod": 200
//}
