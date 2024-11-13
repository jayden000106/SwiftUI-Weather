//
//  WeatherClient.swift
//  Weather
//
//  Created by 정지혁 on 11/5/24.
//

import Foundation

import ComposableArchitecture

enum NetworkMethod: String {
    case get = "GET"
    case post = "POST"
}

@DependencyClient
struct WeatherClient {
    static let apiKey = Bundle.main.infoDictionary?["APIKey"] as! String
    
    static func request<T: Codable>(
        url urlString: String,
        method httpMethod: NetworkMethod,
        queryItems: [URLQueryItem]? = nil,
        parameters: [String: Any?]? = nil,
        type: T.Type
    ) async throws -> T {
        let url = URL(string: "https://api.tomorrow.io/v4/\(urlString)")!
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        var defaultQueryItems: [URLQueryItem] = [URLQueryItem(name: "apikey", value: apiKey)]
        
        if let queryItems {
            defaultQueryItems.append(contentsOf: queryItems)
            defaultQueryItems.reverse()
        }
        components.queryItems = components.queryItems.map { $0 + defaultQueryItems } ?? defaultQueryItems
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = httpMethod.rawValue
        request.timeoutInterval = 10
        if httpMethod == .get {
            request.allHTTPHeaderFields = ["Content-Type": "application/json"]
        } else if httpMethod == .post {
            request.allHTTPHeaderFields = ["accept": "application/json", "Accept-Encoding": "gzip", "content-type": "application/json"]
            
            if let parameters {
                let postData = try JSONSerialization.data(withJSONObject: parameters, options: [])
                request.httpBody = postData
            }
        }
        
        let (data, _) = try await URLSession.shared.data(for: request)
        print(String(decoding: data, as: UTF8.self))
        
        guard let result = try? JSONDecoder().decode(T.self, from: data) else {
            throw NSError(domain: "WeatherClient", code: 1, userInfo: [:])
        }
        return result
    }
    
    var requestLocationHourlyTimelines: @Sendable (Location) async throws -> HourlyWeatherDTO
    var requestLocationDailyTimelines: @Sendable (Location) async throws -> Void
    var requestLocationRealtime: @Sendable (Location) async throws -> RealtimeWeatherDTO
}

extension DependencyValues {
    var weatherClient: WeatherClient {
        get { self[WeatherClient.self] }
        set { self[WeatherClient.self] = newValue }
    }
}

extension WeatherClient: DependencyKey {
    static let liveValue: WeatherClient = Self(
        requestLocationHourlyTimelines: { location in
            let geoPoint = "\(location.latitude), \(location.longitude)"
            let result = try await request(
                url: "timelines",
                method: .post,
                parameters: [
                    "location": geoPoint,
                    "fields": ["temperature", "weatherCode"],
                    "units": "metric",
                    "timesteps": ["1h"],
                    "startTime": "now",
                    "endTime": "nowPlus24h"
                ],
                type: HourlyWeatherDTO.self
            )
            return result
        }, requestLocationDailyTimelines: { location in
            let query = "\(location.latitude), \(location.longitude)"
            
            
        }, requestLocationRealtime: { location in
            let geoPoint = "\(location.latitude), \(location.longitude)"
            let result = try await request(
                url: "weather/realtime",
                method: .get,
                queryItems: [
                    URLQueryItem(name: "location", value: geoPoint)
                ],
                type: RealtimeWeatherDTO.self
            )
            return result
        }
    )
    
    static let previewValue: WeatherClient = Self(
        requestLocationHourlyTimelines: { location in
            try await Task.sleep(for: .seconds(1))
            return HourlyWeatherDTO(
                data: HourlyWeatherData(
                    timelines: [
                        HourlyWeatherTimeLine(
                            timestep: "1h", intervals: [
                                HourlyWeatherInterval(
                                    startTime: "2024-11-13T17:00:00Z",
                                    values: HourlyWeather(temperature: 5.54, weatherCode: 1000)
                                ),
                                HourlyWeatherInterval(
                                    startTime: "2024-11-13T18:00:00Z",
                                    values: HourlyWeather(temperature: 6.24, weatherCode: 1000)
                                ),
                                HourlyWeatherInterval(
                                    startTime: "2024-11-13T19:00:00Z",
                                    values: HourlyWeather(temperature: 6.44, weatherCode: 1000)
                                ),
                                HourlyWeatherInterval(
                                    startTime: "2024-11-13T20:00:00Z",
                                    values: HourlyWeather(temperature: 6.19, weatherCode: 1000)
                                ),
                                HourlyWeatherInterval(
                                    startTime: "2024-11-13T21:00:00Z",
                                    values: HourlyWeather(temperature: 5.26, weatherCode: 1000)
                                ),
                                HourlyWeatherInterval(
                                    startTime: "2024-11-13T22:00:00Z",
                                    values: HourlyWeather(temperature: 3.42, weatherCode: 1000)
                                ),
                                HourlyWeatherInterval(
                                    startTime: "2024-11-13T23:00:00Z",
                                    values: HourlyWeather(temperature: 2.38, weatherCode: 1000)
                                )
                            ]
                        )
                    ]
                )
            )
        }, requestLocationDailyTimelines: { location in
            try await Task.sleep(for: .seconds(1))
        }, requestLocationRealtime: { location in
            try await Task.sleep(for: .seconds(1))
            return RealtimeWeatherDTO(
                data: RealtimeWeatherData(
                    values: RealtimeWeather(weatherCode: 1001, humidity: 85, temperature: 11)
                )
            )
        }
    )
}
