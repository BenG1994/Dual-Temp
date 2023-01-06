//
//  WeatherModelWidget.swift
//  DualTempWidgetExtension
//
//  Created by Ben Gauger on 1/6/23.
//

import Foundation
import SwiftUI


struct WeatherModelWidget {
    
    let conditionId: Int
    let cityName: String
    let temperature: Double
    
    
    var temperatureString: String {
        
        //        var roundNum = temperature.rounded(.toNearestOrAwayFromZero)
        
        
        return String (format: "%.0f", temperature)
        //        round before turning into string. maybe here?
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
}
