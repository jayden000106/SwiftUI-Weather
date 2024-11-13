//
//  HourlyWeather.swift
//  Weather
//
//  Created by 정지혁 on 10/7/24.
//

import Foundation

struct HourlyWeatherDTO: Codable, Equatable, Hashable {
    var data: HourlyWeatherData
}

struct HourlyWeatherData: Codable, Equatable, Hashable {
    var timelines: [HourlyWeatherTimeLine]
}

struct HourlyWeatherTimeLine: Codable, Equatable, Hashable {
    var timestep: String
    var intervals: [HourlyWeatherInterval]
}

struct HourlyWeatherInterval: Codable, Equatable, Hashable {
    var startTime: String
    var values: HourlyWeather
    
    var time: Date? {
        ISO8601DateFormatter().date(from: startTime)
    }
    var hour: Int {
        Calendar.current.component(.hour, from: time ?? Date())
    }
    var weatherIconText: String {
        let isDay = hour > 5 && hour < 19
        
        switch values.weatherCode {
        case 1000, 1100: return isDay ? "sun.max.fill" : "moon.fill"
        case 1101, 1102: return isDay ? "cloud.sun.fill" : "cloud.moon.fill"
        case 1001: return "cloud.fill"
        case 2000: return "cloud.fog.fill"
        case 2100: return isDay ? "sun.haze.fill" : "moon.haze.fill"
        case 4000: return isDay ? "cloud.sun.rain.fill" : "cloud.moon.rain.fill"
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

struct HourlyWeather: Codable, Equatable, Hashable {
    var temperature: Double
    var weatherCode: Int
}
