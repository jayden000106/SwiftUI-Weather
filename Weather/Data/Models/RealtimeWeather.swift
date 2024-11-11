//
//  RealtimeWeather.swift
//  Weather
//
//  Created by 정지혁 on 11/11/24.
//

import Foundation

struct RealtimeWeatherDto: Codable, Equatable {
    var data: RealtimeWeather
}

struct RealtimeWeatherData: Codable, Equatable {
    var values: RealtimeWeather
}

struct RealtimeWeather: Codable, Equatable {
    var humidity: Double
}
