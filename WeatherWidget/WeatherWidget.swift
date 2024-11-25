//
//  WeatherWidget.swift
//  WeatherWidget
//
//  Created by 정지혁 on 11/25/24.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> WeatherEntry {
        WeatherEntry(date: Date())
    }
    
    func getSnapshot(in context: Context, completion: @escaping @Sendable (WeatherEntry) -> Void) {
        completion(WeatherEntry(date: Date()))
    }
    
    func getTimeline(in context: Context, completion: @escaping @Sendable (Timeline<WeatherEntry>) -> Void) {
        var entries: [WeatherEntry] = []
        
        let entry = WeatherEntry(date: Date())
        entries.append(entry)
        
        let timeline = Timeline(entries: entries, policy: .after(Date().addingTimeInterval(3600)))
        completion(timeline)
    }
}

struct WeatherEntry: TimelineEntry {
    let date: Date
    let location: String?
    let temperature: Double?
    let temperatureMin: Double?
    let temperatureMax: Double?
    let weathreCode: Int?
    let hourlyWeather: [HourlyWeather]?
    
    init(
        date: Date,
        location: String? = nil,
        temperature: Double? = nil,
        temperatureMin: Double? = nil,
        temperatureMax: Double? = nil,
        weathreCode: Int? = nil,
        hourlyWeather: [HourlyWeather]? = nil
    ) {
        self.date = date
        self.location = location
        self.temperature = temperature
        self.temperatureMin = temperatureMin
        self.temperatureMax = temperatureMax
        self.weathreCode = weathreCode
        self.hourlyWeather = hourlyWeather
    }
}

struct HourlyWeather {
    let time: Date?
    let temperature: Double?
    let weatherCode: Int?
    
    init(
        time: Date? = nil,
        temperature: Double? = nil,
        weatherCode: Int? = nil
    ) {
        self.time = time
        self.temperature = temperature
        self.weatherCode = weatherCode
    }
}

struct WeatherWidgetEntryView : View {
    @Environment(\.widgetFamily) private var widgetFamily
    
    var entry: Provider.Entry
    
    var body: some View {
        switch widgetFamily {
        case .systemSmall:
            VStack(alignment: .leading, spacing: 4) {
                VStack(alignment: .leading) {
                    Text(entry.location ?? "서울특별시")
                        .font(.subheadline)
                    Text("\(Int(entry.temperature ?? 14))°")
                        .font(.title)
                }
                Spacer()
                VStack(alignment: .leading, spacing: 2) {
                    Image(systemName: getIconText(code: entry.weathreCode ?? 1000))
                        .symbolRenderingMode(.multicolor)
                    Text(getWeatherText(code: entry.weathreCode ?? 1000))
                        .font(.caption)
                    Text("최고:\(Int(entry.temperatureMax ?? 10))° 최저 \(Int(entry.temperatureMax ?? 22))°")
                        .font(.caption)
                }
            }
            .shadow(radius: 4)
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundStyle(.white)
        default:
            VStack(alignment: .leading) {
                Text("Time:")
                Text(entry.date, style: .time)
            }
        }
    }
    
    private func getIconText(code: Int) -> String {
        switch code {
        case 1000, 1100: return "sun.max.fill"
        case 1101, 1102: return "cloud.sun.fill"
        case 1001: return "cloud.fill"
        case 2000: return "cloud.fog.fill"
        case 2100: return "sun.haze.fill"
        case 4000: return "cloud.sun.rain.fill"
        case 4001: return "cloud.rain.fill"
        case 4200: return "cloud.drizzle.fill"
        case 4201: return "cloud.heavyrain.fill"
        case 5000: return "snowflake"
        case 5001: return "cloud.sleet.fill"
        case 5100: return "snowflake"
        case 5101: return "cloud.snow.fill"
        case 6000: return "cloud.sleet.fill"
        case 6001: return "cloud.sleet.fill"
        case 6200: return "cloud.sleet.fill"
        case 6201: return "cloud.sleet.fill"
        case 7000: return "cloud.hail.fill"
        case 7101: return "cloud.hail.fill"
        case 7102: return "cloud.hail.fill"
        case 8000: return "cloud.bolt.rain.fill"
        default: return "sun.max.fill"
        }
    }
    
    private func getWeatherText(code: Int) -> String {
        switch code {
        case 1000: return "청명함"
        case 1100: return "대체로 청명함"
        case 1101: return "부분적으로 흐림"
        case 1102: return "대체로 흐림"
        case 1001: return "흐림"
        case 2000: return "안개"
        case 2100: return "가벼운 안개"
        case 4000: return "이슬비"
        case 4001: return "비"
        case 4200: return "가벼운 비"
        case 4201: return "호우"
        case 5000: return "눈"
        case 5001: return "눈 또는 비"
        case 5100: return "가벼운 눈"
        case 5101: return "폭설"
        case 6000: return "Freezing Drizzle"
        case 6001: return "진눈깨비"
        case 6200: return "약한 진눈깨비"
        case 6201: return "강한 진눈깨비"
        case 7000: return "우박"
        case 7101: return "강한 우박"
        case 7102: return "약한 우박"
        case 8000: return "뇌우"
        default: return "Unknown"
        }
    }
}

struct WeatherWidget: Widget {
    let kind: String = "WeatherWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            WeatherWidgetEntryView(entry: entry)
                .containerBackground(
                    getBackground(code: entry.weathreCode ?? 1000),
                    for: .widget
                )
        }
    }
    
    private func getBackground(code: Int) -> LinearGradient {
        let hour = Calendar.current.component(.hour, from: Date())
        switch code {
        case 1000:
            if hour <= 18 && hour >= 6 {
                return LinearGradient(
                    colors: [
                        Color("ClearNightTop"),
                        Color("ClearNightBottom")
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            } else {
                return LinearGradient(
                    colors: [
                        Color("ClearDayTop"),
                        Color("ClearDayBottom")
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            }
        default:
            if hour <= 18 && hour >= 6 {
                return LinearGradient(
                    colors: [
                        Color("CloudyDayTop"),
                        Color("CloudyDayBottom")
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            } else {
                return LinearGradient(
                    colors: [
                        Color("CloudyDayTop"),
                        Color("CloudyDayBottom")
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            }
        }
    }
}

#Preview(as: .systemSmall) {
    WeatherWidget()
} timeline: {
    WeatherEntry(date: .now)
}
