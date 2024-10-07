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
