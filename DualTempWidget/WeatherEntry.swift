//
//  WeatherEntry.swift
//  DualTempWidgetExtension
//
//  Created by Ben Gauger on 1/6/23.
//

import WidgetKit


struct WeatherEntry: TimelineEntry {
    let date: Date
    let weatherData: WeatherModel?
}
