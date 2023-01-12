//
//  WeatherEntry.swift
//  DualTempWidgetExtension
//
//  Created by Ben Gauger on 1/12/23.
//

import WidgetKit
import SwiftUI

struct WeatherEntry: TimelineEntry {
    let date: Date
    let name: String
    let temperature: Main
}
