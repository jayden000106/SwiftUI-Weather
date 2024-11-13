//
//  Location.swift
//  Weather
//
//  Created by 정지혁 on 11/5/24.
//

struct Location: Identifiable, Hashable, Equatable {
    var id: String { name }
    
    var name: String
    var latitude: Double
    var longitude: Double
    var tag: String?
    
    var realtimeWeather: RealtimeWeather?
    var hourlyWeatherIntervals: [HourlyWeatherInterval]?
}

struct LocationWeatherData {
    let realtimeWeather: RealtimeWeather
    let hourlyWeatherIntervals: [HourlyWeatherInterval]
}

let dummyLocations = [
    Location(name: "서울", latitude: 37.566535, longitude: 126.9779692, tag: "나의 위치"),
    Location(name: "대전", latitude: 36.3504119, longitude: 127.3845475),
]
