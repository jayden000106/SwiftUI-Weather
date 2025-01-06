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
        Task {
            var entries: [WeatherEntry] = []
            let date = Date()
            let location = WeatherClient.location
            
            do {
                let realtimeWeatherDTO = try await WeatherClient.shared.requestLocationRealtime(location: location)
                let dailyWeatherDTO = try await WeatherClient.shared.requestLocationDailyTimelines(location: location)
                let hourlyWeatherDTO = try await WeatherClient.shared.requestLocationHourlyTimelines(location: location)
                
                let entry = WeatherEntry(
                    date: date,
                    realtimeWeather: realtimeWeatherDTO.data.values,
                    dailyWeatherInterval: dailyWeatherDTO.data.timelines.first?.intervals,
                    hourlyWeatherInterval: hourlyWeatherDTO.data.timelines.first?.intervals
                )
                entries.append(entry)
                
                let timeline = Timeline(entries: entries, policy: .after(Date().addingTimeInterval(3600)))
                completion(timeline)
            } catch {
                print(error)
                
                let entry = WeatherEntry(date: date, location: location)
                entries.append(entry)
                let timeline = Timeline(entries: entries, policy: .after(Date().addingTimeInterval(3600)))
                completion(timeline)
            }
        }
    }
}

struct WeatherEntry: TimelineEntry {
    let date: Date
    let location: Location
    let realtimeWeather: RealtimeWeather?
    let dailyWeatherInterval: [DailyWeatherInterval]?
    let hourlyWeatherInterval: [HourlyWeatherInterval]?
    
    init(
        date: Date,
        location: Location = WeatherClient.location,
        realtimeWeather: RealtimeWeather? = nil,
        dailyWeatherInterval: [DailyWeatherInterval]? = nil,
        hourlyWeatherInterval: [HourlyWeatherInterval]? = nil
    ) {
        self.date = date
        self.location = location
        self.realtimeWeather = realtimeWeather
        self.dailyWeatherInterval = dailyWeatherInterval
        self.hourlyWeatherInterval = hourlyWeatherInterval
    }
}

struct WeatherWidgetEntryView: View {
    @Environment(\.widgetFamily) private var widgetFamily
    
    var entry: Provider.Entry
    
    var body: some View {
        switch widgetFamily {
        case .systemSmall:
            SmallWeatherWidgetView(entry: entry)
        case .systemMedium:
            MediumWeatherWidgetView(entry: entry)
        default:
            LargeWeatherWidgetView(entry: entry)
        }
    }
    
    struct SmallWeatherWidgetView: View {
        var entry: Provider.Entry
        
        var body: some View {
            VStack(alignment: .leading, spacing: 4) {
                VStack(alignment: .leading) {
                    Text(entry.location.name)
                        .font(.subheadline)
                    Text("\(Int(entry.realtimeWeather?.temperature ?? 0))°")
                        .font(.title)
                }
                Spacer()
                VStack(alignment: .leading, spacing: 2) {
                    Image(systemName: getIconText(code: entry.realtimeWeather?.weatherCode ?? 1000))
                        .symbolRenderingMode(.multicolor)
                    Text(getWeatherText(code: entry.realtimeWeather?.weatherCode ?? 1000))
                        .font(.caption)
                    Text("최고:\(Int(entry.dailyWeatherInterval?.first?.values.temperatureMax ?? 0))° 최저 \(Int(entry.dailyWeatherInterval?.first?.values.temperatureMin ?? 0))°")
                        .font(.caption)
                }
            }
            .shadow(radius: 4)
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundStyle(.white)
        }
    }
    
    struct MediumWeatherWidgetView: View {
        var entry: Provider.Entry
        
        var body: some View {
            VStack(alignment: .leading) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(entry.location.name)
                            .font(.subheadline)
                        Text("\(Int(entry.realtimeWeather?.temperature ?? 0))°")
                            .font(.title)
                    }
                    Spacer()
                    VStack(alignment: .trailing, spacing: 2) {
                        Image(systemName: getIconText(code: entry.realtimeWeather?.weatherCode ?? 1000))
                            .symbolRenderingMode(.multicolor)
                        Text(getWeatherText(code: entry.realtimeWeather?.weatherCode ?? 1000))
                            .font(.caption)
                        Text("최고:\(Int(entry.dailyWeatherInterval?.first?.values.temperatureMax ?? 0))° 최저 \(Int((entry.dailyWeatherInterval?.first?.values.temperatureMin ?? 0)))°")
                            .font(.caption)
                    }
                }
                Spacer()
                HStack {
                    ForEach((entry.hourlyWeatherInterval ?? []).prefix(6), id: \.self) { interval in
                        VStack(spacing: 4) {
                            Text("\(interval.hour)시")
                                .font(.caption2)
                            Image(systemName: getIconText(code: interval.values.weatherCode))
                                .symbolRenderingMode(.multicolor)
                            Text("\(Int(interval.values.temperature))°")
                                .font(.caption)
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
            }
            .shadow(radius: 4)
            .foregroundStyle(.white)
        }
    }
    
    struct LargeWeatherWidgetView: View {
        var entry: Provider.Entry
        
        private var range: CGFloat {
            return 120 / CGFloat(maxTempertureOfWeek - minTempertureOfWeek)
        }
        private var maxTempertureOfWeek: Double {
            return entry.dailyWeatherInterval?.map { $0.values.temperatureMax }.max() ?? 40
        }
        private var minTempertureOfWeek: Double {
            return entry.dailyWeatherInterval?.map { $0.values.temperatureMin }.min() ?? 0
        }
        
        var body: some View {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(entry.location.name)
                            .font(.subheadline)
                        Text("\(Int(entry.realtimeWeather?.temperature ?? 14))°")
                            .font(.title)
                    }
                    Spacer()
                    VStack(alignment: .trailing, spacing: 2) {
                        Image(systemName: getIconText(code: entry.realtimeWeather?.weatherCode ?? 1000))
                            .symbolRenderingMode(.multicolor)
                        Text(getWeatherText(code: entry.realtimeWeather?.weatherCode ?? 1000))
                            .font(.caption)
                        Text("최고:\(Int(entry.dailyWeatherInterval?.first?.values.temperatureMax ?? 0))° 최저 \(Int(entry.dailyWeatherInterval?.first?.values.temperatureMin ?? 0))°")
                            .font(.caption)
                    }
                }
                Divider()
                HStack {
                    ForEach((entry.hourlyWeatherInterval ?? []).prefix(6), id: \.self) { interval in
                        VStack(spacing: 4) {
                            Text("\(interval.hour)시")
                                .font(.caption)
                            Image(systemName: getIconText(code: interval.values.weatherCode))
                                .symbolRenderingMode(.multicolor)
                            Text("\(Int(interval.values.temperature))°")
                                .font(.caption)
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
                Divider()
                VStack(spacing: 12) {
                    ForEach((entry.dailyWeatherInterval ?? []).prefix(5), id: \.self) { interval in
                        HStack(spacing: 0) {
                            Text(interval.weekdayText)
                            
                            Spacer()
                            
                            Image(systemName: getIconText(code: interval.values.weatherCode))
                                .symbolRenderingMode(.multicolor)
                            
                            Spacer()
                            
                            HStack {
                                Text("\(Int(interval.values.temperatureMin))°")
                                
                                ZStack {
                                    RoundedRectangle(cornerRadius: 4)
                                        .fill(.black.opacity(0.4))
                                        .frame(height: 2)
                                    
                                    RoundedRectangle(cornerRadius: 4)
                                        .foregroundStyle(
                                            .linearGradient(
                                                colors: [Color.green, Color.yellow],
                                                startPoint: .leading,
                                                endPoint: .trailing
                                            )
                                        )
                                        .frame(height: 2)
                                        .padding(.leading, CGFloat((interval.values.temperatureMin - minTempertureOfWeek)) * range)
                                        .padding(.trailing, CGFloat((maxTempertureOfWeek - interval.values.temperatureMax)) * range)
                                }
                                .frame(width: 120)
                                
                                Text("\(Int(interval.values.temperatureMax))°")
                            }
                        }
                    }
                }
                Spacer()
            }
            .shadow(radius: 4)
            .foregroundStyle(.white)
        }
    }
    
    private static func getIconText(code: Int) -> String {
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
    
    private static func getWeatherText(code: Int) -> String {
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
                    getBackground(code: entry.realtimeWeather?.weatherCode ?? 1000),
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

#Preview(as: .systemLarge) {
    WeatherWidget()
} timeline: {
    WeatherEntry(date: .now)
}
