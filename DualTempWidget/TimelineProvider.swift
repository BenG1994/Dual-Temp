//
//  TimelineProvider.swift
//  DualTempWidgetExtension
//
//  Created by Ben Gauger on 1/12/23.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> WeatherEntry {
        WeatherEntry(date: Date(), name: "", temperature: Main(temp: <#T##Double#>, pressure: <#T##Int#>, feels_like: <#T##Double#>, temp_min: <#T##Double#>, temp_max: <#T##Double#>, humidity: <#T##Int#>))
    }

    func getSnapshot(in context: Context, completion: @escaping (WeatherEntry) -> ()) {
        let entry = WeatherEntry(date: Date(), name: "")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<WeatherEntry>) -> ()) {
        var entries: [WeatherEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = WeatherEntry(date: entryDate, name: "")
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}
