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
    func didUpdateWeatherFahrenheit( _weatherManager: WeatherManager, weather: WeatherModelFahrenheit)
//    func didUpdateWeatherMetric ( _weatherManager: WeatherManager, weather: WeatherModelMetric)
//    func didUpdateWeatherImperial ( _weatherManager: WeatherManager, weather: WeatherModelImperial)
    func didFailWithError (error:Error)
}

struct WeatherManager {
    
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=147b36d894b7480cc937f8d7e03a4af0&units=metric"
    
    let weatherURLFahrenheit = "https://api.openweathermap.org/data/2.5/weather?appid=147b36d894b7480cc937f8d7e03a4af0&units=imperial"
    //
    //    //    "https://api.openweathermap.org/data/2.5/weather?appid=147b36d894b7480cc937f8d7e03a4af0&units=metric"
    //
    
    //    let cityNameString = cityName.replacingOccurrences(of: " ", with: "+")
    
    var delegate: WeatherManagerDelegate?
    
    
    
    func fetchWeather (cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    func fetchWeatherFahrenheit (cityName: String) {
        let urlString = "\(weatherURLFahrenheit)&q=\(cityName)"
        performRequestFahrenheit(with: urlString)
        
    }
    
    
    func fetchWeatherFahrenheit(latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        let urlString = "\(weatherURLFahrenheit)&lat=\(latitude)&lon=\(longitude)"
        performRequestFahrenheit(with: urlString)
    }
    
//    func fetchWeatherMetric (cityName: String) {
//        let urlString = "\(weatherURL)&q=\(cityName)"
//        performRequestMetric(with: urlString)
//    }
//
//
//    func fetchWeatherMetric(latitude: CLLocationDegrees, longitude: CLLocationDegrees){
//        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
//        performRequestMetric(with: urlString)
//    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
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
            let feels = decodedData.main.feels_like
            let visibility = decodedData.visibility
            let humidity = decodedData.main.humidity
            let wind = decodedData.wind.speed
            let sunrise = decodedData.sys.sunrise
            let sunset = decodedData.sys.sunset
            let timezone = decodedData.timezone
            let country = decodedData.sys.country
            let latitude = decodedData.coord.lat
            let longitude = decodedData.coord.lon
            
            let weather = WeatherModel(
                conditionId: id,
                cityName: name,
                temperature: temp,
                feels_like: feels,
                visibility: visibility,
                humidity: humidity,
                wind: wind,
                sunrise: sunrise,
                sunset: sunset,
                timezone: timezone,
                country: country,
                latitude: latitude,
                longitude: longitude)
            
//            UserDefaults(suiteName:
//            "group.DualTemp")!.set(decodedData, forKey: "weather")
            
            return weather
        }catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    //MARK: - Fahrenheit
    
    func performRequestFahrenheit(with urlString: String) {
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSONFahrenheit(safeData) {
                        self.delegate?.didUpdateWeatherFahrenheit(_weatherManager: self, weather: weather)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSONFahrenheit (_ weatherData: Data) -> WeatherModelFahrenheit? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let name = decodedData.name
            let temp = decodedData.main.temp
            let feels = decodedData.main.feels_like
            let visibility = decodedData.visibility
            let wind = decodedData.wind.speed
            
            let weather = WeatherModelFahrenheit(
                conditionId: id,
                cityName: name,
                temperatureFahrenheit: temp,
                feels_likeFahrenheit: feels,
                visibilityImperial: visibility,
                windImperial: wind)
            return weather
        }catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
//    //MARK: - Button Press Celsius
//
//    func performRequestMetric(with urlString: String) {
//        if let url = URL(string: urlString){
//            let session = URLSession(configuration: .default)
//            let task = session.dataTask(with: url) { (data, response, error) in
//                if error != nil {
//                    self.delegate?.didFailWithError(error: error!)
//                    return
//                }
//                if let safeData = data {
//                    if let weather = self.parseJSONMetric(safeData) {
//                        self.delegate?.didUpdateWeatherMetric(_weatherManager: self, weather: weather)
//                    }
//                }
//            }
//            task.resume()
//        }
//    }
//
//    func parseJSONMetric (_ weatherData: Data) -> WeatherModelMetric? {
//        let decoder = JSONDecoder()
//        do {
//            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
//            let feels = decodedData.main.feels_like
//            let visibility = decodedData.visibility
//
//            let wind = decodedData.wind.speed
//
//            let weather = WeatherModelMetric(
//                feelsLikeCelsius: feels,
//                visibilityMetric: visibility,
//                windSpeedMetric: wind)
//
//            return weather
//        }catch {
//            delegate?.didFailWithError(error: error)
//            return nil
//        }
//    }
//
//    //MARK: - Press Button Imperial
//    func performRequestImperial(with urlString: String) {
//        if let url = URL(string: urlString){
//            let session = URLSession(configuration: .default)
//            let task = session.dataTask(with: url) { (data, response, error) in
//                if error != nil {
//                    self.delegate?.didFailWithError(error: error!)
//                    return
//                }
//                if let safeData = data {
//                    if let weather = self.parseJSONImperial(safeData) {
//                        self.delegate?.didUpdateWeatherImperial(_weatherManager: self, weather: weather)
//                    }
//                }
//            }
//            task.resume()
//        }
//    }
//
//    func parseJSONImperial (_ weatherData: Data) -> WeatherModelImperial? {
//        let decoder = JSONDecoder()
//        do {
//            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
//            let feels = decodedData.main.feels_like
//            let visibility = decodedData.visibility
//
//            let wind = decodedData.wind.speed
//
//            let weather = WeatherModelImperial(
//                feelsLikeFahrenheit: feels,
//                visibilityImperial: visibility,
//                windSpeedImperial: wind)
//
//            return weather
//        }catch {
//            delegate?.didFailWithError(error: error)
//            return nil
//        }
//    }
//
}



