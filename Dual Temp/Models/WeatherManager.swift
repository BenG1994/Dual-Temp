////
////  WeatherManager.swift
////  Clima
////
////  Created by Ben Gauger on 9/6/22
////
//
import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError (error:Error)
}

struct WeatherManager {
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=147b36d894b7480cc937f8d7e03a4af0&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather (cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON (_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let name = decodedData.name
            let temp = decodedData.main.temp
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            return weather
        }catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}


















//MARK: - FIRST ATTEMPT FAILURE

//import Foundation
//import CoreLocation
//
//protocol WeatherManagerDelegate{
//    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
//    func didFailWithError(error:Error)
//}
//
//struct WeatherManager {
//
//    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=147b36d894b7480cc937f8d7e03a4af0&units=metric"
//
//    var delegate: WeatherManagerDelegate?
//
//    func fetchWeather (cityName: String) {
//        let urlString = "\(weatherURL)&q=\(cityName)"
//        performRequest(with: urlString)
//    }
//
//    func fetchWeather(latitde: CLLocationDegrees, longitude: CLLocationDegrees) {
//        let urlString = "\(weatherURL)&lat=\(latitde)&=lon\(longitude)"
//        performRequest(with: urlString)
//    }
//
////    func fetchWeatherCelsius (cityName: String) {
////        let urlString = "\(weatherURL)&q=\(cityName)&units=metric"
////        performRequest(with: urlString)
////    }
////
////    func fetchWeatherFahrenheit (cityName: String) {
////        let urlString = "\(weatherURL)&q=\(cityName)&units=imperial"
////        performRequest(with: urlString)
////    }
//
////    func fetchWeather(latitde: CLLocationDegrees, longitude: CLLocationDegrees) {
////        let urlString = "\(weatherURL)&lat=\(latitde)&=lon\(longitude)"
////        performRequest(with: urlString)
////    }
//
//    func performRequest(with urlString: String) {
//        if let url = URL(string: urlString){
//            let session = URLSession(configuration: .default)
//            let task = session.dataTask(with: url) { data, response, error in
//                if error != nil{
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
//
//    }
//
//    func parseJSON (_ weatherData: Data) -> WeatherModel? {
//        let decoder = JSONDecoder()
//        do {
//            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
//            let id = decodedData.weather[0].id
//            let temp = decodedData.main.temp
//            let name = decodedData.name
//
//            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
////            let weather = WeatherModel(conditionId: id, cityName: name, temperatureCelsius: temp, temperatureFahrenheit: temp)
//            return weather
//
//        }catch {
//            delegate?.didFailWithError(error: error)
//            return nil
//        }
//    }
//
//
//
//    }
//
//
//    //copy for imperial units, to have both at the same time
//    //toggle to swithc between the two for the bottom stats
//    //have both metric and imperial on the top with the weather icon in the middle and the condition text below the two
//    //have background change as well with the weather? Maybe, if I can find enough good weather backgrounds.
//
//    //func performRequest(urlString: String) {
//    //    if let url = URL(string: urlString){
//    //        let session = URLSession(configuration: .default)
//    //        let task = session.dataTask(with: url, completionHandler: handle(data: response: error:))
//    //        task.resume()
//    //    }
//
//    //func handle(data: Data?, response: URLResponse?, error: Error?){
//    //    if error != nil{
//    //        print(error!)
//    //        return
//    //    }
//    //
//    //    if let safeData = data {
//    //        let dataString = String(data: safeData, encoding: .utf8)
//    //        print(dataString)
//    //    }
//
//
//////
//////  WeatherManager.swift
//////  Dual Temp
//////
//////  Created by Ben Gauger on 10/19/22.
//////
////
////import Foundation
////import CoreLocation
////
////protocol WeatherManagerDelegate {
////    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
////    func didFailWithError(error:Error)
////}
////
////struct WeatherManager {
////
////    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=147b36d894b7480cc937f8d7e03a4af0"
////
////    var delegate: WeatherManagerDelegate?
////
////    func fetchWeatherCelsius (cityName: String){
////        let urlStringCelsius = "\(weatherURL)&q=\(cityName)&units=metric"
////        performRequest (with: urlStringCelsius)
////    }
////
////    func fetchWeatherFahrenheit (cityName: String){
////        let urlStringFahrenheit = "\(weatherURL)&q=\(cityName)&units=imperial"
////        performRequest(with: urlStringFahrenheit)
////    }
////
////    func fetchWeather(latitde: CLLocationDegrees, longitude: CLLocationDegrees) {
////        let urlString = "\(weatherURL)&lat=\(latitde)&=lon\(longitude)"
////        performRequest(with: urlString)
////
////
////
////        func performRequest(with urlString: String) {
////            if let url = URL(string: urlString){
////                let session = URLSession(configuration: .default)
////                let task = session.dataTask(with: url) { data, response, error in
////                    if error != nil{
////                        self.delegate.didFailWithError(error: error!)
////                        return
////                    }
////                    if let safeData = data {
////                        if let weather = self.parseJSON(safeData) {
////                            self.delegate?.didUpdateWeather(self, weather: weather)
////                        }
////                    }
////                }
////                task.resume()
////            }
////        }
////
////        func parseJSON (_ weatherData: Data) -> WeatherModel? {
////            let decoder = JSONDecoder()
////            do {
////                let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
////                let id = decodedData.weather[0].id
////                let temp = decodedData.main.temp
////                let name = decodedData.name
////
////                let weather = WeatherModel(conditionId: id, cityName: name, temperatureCelsius: temp, temperatureFahrenheit: temp)
////                return weather
////
////            }catch {
////                delegate.didFailWithError(error: error)
////                return nil
////            }
////        }
////    }
////}
