//
//  RealtimeWeather.swift
//  Weather
//
//  Created by 정지혁 on 11/11/24.
//

import Foundation

struct RealtimeWeatherDTO: Codable, Equatable, Hashable {
    var data: RealtimeWeatherData
}

struct RealtimeWeatherData: Codable, Equatable, Hashable {
    var values: RealtimeWeather
}

struct RealtimeWeather: Codable, Equatable, Hashable {
    var humidity: Double
    var temperature: Double
}
