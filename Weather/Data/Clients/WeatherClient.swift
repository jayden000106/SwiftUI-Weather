//
//  WeatherClient.swift
//  Weather
//
//  Created by 정지혁 on 11/5/24.
//

import Foundation

import ComposableArchitecture

@DependencyClient
struct WeatherClient {
    static let APIKey = Bundle.main.infoDictionary?["APIKey"] as! String
}

extension DependencyValues {
    var weatherClient: WeatherClient {
        get { self[WeatherClient.self] }
        set { self[WeatherClient.self] = newValue }
    }
}

extension WeatherClient: DependencyKey {
    static let liveValue: WeatherClient = Self()
}
