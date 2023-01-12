//
//  WidgetView.swift
//  DualTempWidgetExtension
//
//  Created by Ben Gauger on 1/12/23.
//

import WidgetKit
import SwiftUI
import WeatherKit
import CoreLocation

struct DualTempWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        ZStack{
            Color("WidgetBackground")
            
            VStack{
                Text(entry.date, style: .time)
                
                HStack{
                    Text(entry.name)
            }
            }
       
        }
        
        

    }
}
