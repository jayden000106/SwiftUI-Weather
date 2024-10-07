//
//  DailyWeather.swift
//  Weather
//
//  Created by 정지혁 on 10/7/24.
//

import Foundation

struct DailyWeather: Hashable {
    let weekday: String
    let weatherCode: Int
    let minTemperture: Int
    let maxTemperture: Int
    
    init(weekday: String, weatherCode: Int, minTemperture: Int, maxTemperture: Int) {
        self.weekday = weekday
        self.weatherCode = weatherCode
        self.minTemperture = minTemperture
        self.maxTemperture = maxTemperture
    }
}

let dummyDailyWeather: [DailyWeather] = [
    DailyWeather(
        weekday: "오늘",
        weatherCode: 3,
        minTemperture: 11,
        maxTemperture: 24
    ),
    DailyWeather(
        weekday: "월",
        weatherCode: 3,
        minTemperture: 12,
        maxTemperture: 23
    ),
    DailyWeather(
        weekday: "화",
        weatherCode: 3,
        minTemperture: 11,
        maxTemperture: 22
    ),
    DailyWeather(
        weekday: "수",
        weatherCode: 3,
        minTemperture: 13,
        maxTemperture: 23
    ),
    DailyWeather(
        weekday: "목",
        weatherCode: 3,
        minTemperture: 12,
        maxTemperture: 24
    ),
    DailyWeather(
        weekday: "금",
        weatherCode: 3,
        minTemperture: 12,
        maxTemperture: 24
    ),
    DailyWeather(
        weekday: "토",
        weatherCode: 3,
        minTemperture: 12,
        maxTemperture: 24
    ),
    DailyWeather(
        weekday: "일",
        weatherCode: 3,
        minTemperture: 12,
        maxTemperture: 24
    ),
    DailyWeather(
        weekday: "월",
        weatherCode: 3,
        minTemperture: 12,
        maxTemperture: 24
    ),
    DailyWeather(
        weekday: "화",
        weatherCode: 3,
        minTemperture: 12,
        maxTemperture: 24
    )
]
