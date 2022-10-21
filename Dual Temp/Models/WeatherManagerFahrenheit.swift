////
////  WeatherManagerFahrenheit.swift
////  Dual Temp
////
////  Created by Ben Gauger on 10/21/22.
////
//
//import Foundation
//import CoreLocation
//
//protocol WeatherManagerDelegate2 {
//    func didUpdateWeather(_ weatherManager: WeatherManagerFahrenheit, weather: WeatherModel)
//    func didFailWithError (error:Error)
//}
//
//struct WeatherManagerFahrenheit {
//    
//    let weatherURLFahrenheit = "https://api.openweathermap.org/data/2.5/weather?appid=147b36d894b7480cc937f8d7e03a4af0&units=imperial"
//
//    var delegate: WeatherManagerDelegate2?
//
//    func fetchWeatherFahrenheit (cityName: String) {
//        let urlString = "\(weatherURLFahrenheit)&q=\(cityName)"
//        performRequest(with: urlString)
//    }
//
//
//    func fetchWeatherFahrenheit(latitude: CLLocationDegrees, longitude: CLLocationDegrees){
//        let urlString = "\(weatherURLFahrenheit)&lat=\(latitude)&lon=\(longitude)"
//        performRequest(with: urlString)
//    }
//
//    func performRequest(with urlString: String) {
//        if let url = URL(string: urlString){
//            let session = URLSession(configuration: .default)
//            let task = session.dataTask(with: url) { (data, response, error) in
//                if error != nil {
//                    self.delegate?.didFailWithError(error: error!)
//                    return
//                }
//                if let safeData = data {
//                    if let weather = self.parseJSON(safeData) {
//                        self.delegate?.didUpdateWeather(self, weather: weather)
//                    }
//                }
//            }
//            task.resume()
//        }
//    }
//
//    func parseJSON (_ weatherData: Data) -> WeatherModel? {
//        let decoder = JSONDecoder()
//        do {
//            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
//            let id = decodedData.weather[0].id
//            let name = decodedData.name
//            let temp = decodedData.main.temp
//
//            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
//            return weather
//        }catch {
//            delegate?.didFailWithError(error: error)
//            return nil
//        }
//    }
//}
