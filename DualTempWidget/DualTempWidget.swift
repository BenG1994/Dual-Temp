//
//  DualTempWidget.swift
//  DualTempWidget
//
//  Created by Ben Gauger on 2/6/23.
//

import WidgetKit
import SwiftUI
import CoreLocation


let otherUserDefaults = UserDefaults(suiteName: "group.DualTemp")

let temperatureCelsius = otherUserDefaults?.value(forKey: "CTempWidget") ?? 0

let temperatureFahrenheit = otherUserDefaults?.value(forKey: "FTempWidget")

let name = otherUserDefaults?.value(forKey: "SearchedCityWidget")

let weatherID = otherUserDefaults?.string(forKey: "WidgetIcon")

let weather = UIImage(systemName: weatherID!)

func getTime() -> String {
    let formatter = DateFormatter()
    formatter.timeStyle = .short
    let dateString = formatter.string(from: Date())
    return dateString
}


struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), name: "", temperatureCelsius: "0°C", temperatureFahrenheit: "0°F", weatherName: "Cloud", weatherIcon: weather!)
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), name: name as! String , temperatureCelsius: temperatureCelsius as! String, temperatureFahrenheit: temperatureFahrenheit as! String, weatherName: "sun", weatherIcon: weather!)
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        
        
        
        let userDefaults = UserDefaults(suiteName: "group.DualTemp")
        
        let temperatureCelsius = userDefaults?.value(forKey: "CTempWidget") ?? 0
        
        let temperatureFahrenheit = userDefaults?.value(forKey: "FTempWidget")
        
        let name = userDefaults?.value(forKey: "SearchedCityWidget")
        
        let weatherName = userDefaults?.string(forKey: "WidgetIcon")
        
        let weatherImage = UIImage(systemName: weatherName!)
        
        
        //MARK: - refresh info
        
        //        let totalCountdown = 30
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        
        let currentDate = Date()
        let refreshDate = Calendar.current.date(byAdding: .minute, value: 30, to: currentDate)!
        let entry = SimpleEntry(date: currentDate, name: name as? String ?? "No location", temperatureCelsius: temperatureCelsius as? String ?? "0°C", temperatureFahrenheit: temperatureFahrenheit as? String ?? "0°F", weatherName: weatherName!,
                                weatherIcon: weatherImage!)
        entries.append(entry)
        
        
        
        let timeline = Timeline(entries: entries, policy: .after(refreshDate))
        completion(timeline)
    }
    
    struct SimpleEntry: TimelineEntry {
        let date: Date
        let name: String
        let temperatureCelsius: String
        let temperatureFahrenheit: String
        let weatherName: String
        let weatherIcon: UIImage
    }
    
    struct DualTempWidgetEntryView : View {
        
        var entry: Provider.Entry
        
        var body: some View {
            
            ZStack{
                Color("WidgetBackground")
                VStack(spacing: 0.8) {
                    if #available(iOSApplicationExtension 16.0, *) {
                        Text(entry.name)
                            .padding(6)
                            .bold()
                            .font(.system(size: 27))
                            .minimumScaleFactor(0.01)
                            .lineLimit(1)
                    } else {
                        Text(entry.name)
                            .padding(6)
                            .font(.system(size: 29))
                            .minimumScaleFactor(0.01)
                            .lineLimit(1)
                        // Fallback on earlier versions
                    }
                    Image(systemName: entry.weatherName)
                        .resizable()
                        .symbolRenderingMode(.palette)
                        .scaledToFit()
                        .frame(width: 70, height: 70)
                    HStack{
                        Text(entry.temperatureCelsius)
                            .font(.system(size: 22))
                        Text("|")
                        Text(entry.temperatureFahrenheit)
                            .font(.system(size: 22))
                        
                    }
                    Text("Updated: \(getTime())")
                        .font(.system(size: 7))
                }
            }
        }
    }
    
    struct DualTempWidget: Widget {
        let kind: String = "DualTempWidget"
        
        var body: some WidgetConfiguration {
            StaticConfiguration(kind: kind, provider: Provider()) { entry in
                DualTempWidgetEntryView(entry: entry)
            }
            .configurationDisplayName("Dual Temp")
            .description("See the current temperature, in celsius and fahrenheit, and weather conditions for your location.")
            .supportedFamilies([.systemSmall])
        }
    }
    
    struct DualTempWidget_Previews: PreviewProvider {
        static var previews: some View {
            DualTempWidgetEntryView(entry: SimpleEntry(date: Date(), name: name as! String , temperatureCelsius: temperatureCelsius as! String, temperatureFahrenheit: temperatureFahrenheit as! String, weatherName: weatherID!, weatherIcon: weather!))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
        }
    }
    
    
}









//MARK: - working timeline for widget

//func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
//    var entries: [SimpleEntry] = []
//
//
//
//    let userDefaults = UserDefaults(suiteName: "group.DualTemp")
//
//    let temperatureCelsius = userDefaults?.value(forKey: "CTempWidget") ?? 0
//
//    let temperatureFahrenheit = userDefaults?.value(forKey: "FTempWidget")
//
//    let name = userDefaults?.value(forKey: "SearchedCityWidget")
//
//    let weatherName = userDefaults?.string(forKey: "WidgetIcon")
//
//    let weatherImage = UIImage(systemName: weatherName!)
//
//
//    //MARK: - refresh info
//
////        let totalCountdown = 30
//    // Generate a timeline consisting of five entries an hour apart, starting from the current date.
//
//    let currentDate = Date()
//        let refreshDate = Calendar.current.date(byAdding: .minute, value: 30, to: currentDate)!
//        let entry = SimpleEntry(date: currentDate, name: name as? String ?? "No location", temperatureCelsius: temperatureCelsius as? String ?? "0°C", temperatureFahrenheit: temperatureFahrenheit as? String ?? "0°F", weatherName: weatherName!,
//                                weatherIcon: weatherImage!)
//        entries.append(entry)
//
//
//
//    let timeline = Timeline(entries: entries, policy: .after(refreshDate))
//    completion(timeline)
//}
