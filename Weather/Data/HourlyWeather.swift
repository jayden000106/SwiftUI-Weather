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

let dummyHourlyWeather: [HourlyWeather] = [
    HourlyWeather(
        time: "지금",
        weatherCode: 3,
        temperture: 21
    ),
    HourlyWeather(
        time: "12시",
        weatherCode: 3,
        temperture: 22
    ),
    HourlyWeather(
        time: "13시",
        weatherCode: 3,
        temperture: 23
    ),
    HourlyWeather(
        time: "14시",
        weatherCode: 3,
        temperture: 23
    ),
    HourlyWeather(
        time: "15시",
        weatherCode: 3,
        temperture: 23
    ),
    HourlyWeather(
        time: "16시",
        weatherCode: 3,
        temperture: 22
    ),
    HourlyWeather(
        time: "17시",
        weatherCode: 3,
        temperture: 21
    ),
    HourlyWeather(
        time: "18시",
        weatherCode: 3,
        temperture: 21
    ),
    HourlyWeather(
        time: "19시",
        weatherCode: 3,
        temperture: 20
    )
]
