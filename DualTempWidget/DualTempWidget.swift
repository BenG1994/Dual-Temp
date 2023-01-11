//
//  DualTempWidget.swift
//  DualTempWidget
//
//  Created by Ben Gauger on 1/6/23.
//

import WidgetKit
import SwiftUI
import WeatherKit







struct DualTempWidget: Widget {
    let kind: String = "DualTempWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            DualTempWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Dual Temp")
        .description("This is an example widget.")
    
    }
}

struct DualTempWidget_Previews: PreviewProvider {
    static var previews: some View {
        DualTempWidgetEntryView(entry: WeatherEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
        
        
    }
    
    
    
}
