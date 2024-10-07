//
//  HourlyWeather.swift
//  Weather
//
//  Created by 정지혁 on 10/7/24.
//

import Foundation

struct HourlyWeather: Hashable {
    let time: String
    let weatherCode: Int
    let temperture: Int
    
    init(time: String, weatherCode: Int, temperture: Int) {
        self.time = time
        self.weatherCode = weatherCode
        self.temperture = temperture
    }
}
