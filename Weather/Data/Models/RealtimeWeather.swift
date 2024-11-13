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
    var weatherCode: Int
    var humidity: Int
    var temperature: Double
    
    var weatherText: String {
        switch weatherCode {
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
