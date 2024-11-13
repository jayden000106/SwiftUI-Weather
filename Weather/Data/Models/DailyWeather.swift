//
//  DailyWeather.swift
//  Weather
//
//  Created by 정지혁 on 10/7/24.
//

import Foundation

struct DailyWeatherDTO: Codable, Equatable, Hashable {
    var data: DailyWeatherData
}

struct DailyWeatherData: Codable, Equatable, Hashable {
    var timelines: [DailyWeatherTimeLine]
}

struct DailyWeatherTimeLine: Codable, Equatable, Hashable {
    var timestep: String
    var intervals: [DailyWeatherInterval]
}

struct DailyWeatherInterval: Codable, Equatable, Hashable {
    var startTime: String
    var values: DailyWeather
    
    var weekdayText: String {
        let isoFormatter = ISO8601DateFormatter()
        let date = isoFormatter.date(from: startTime)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        return dateFormatter.string(from: date ?? Date())
    }
    var weatherIconText: String {
        switch values.weatherCode {
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
}

struct DailyWeather: Codable, Equatable, Hashable {
    var temperatureMin: Double
    var temperatureMax: Double
    var weatherCode: Int
}
