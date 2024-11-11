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
    
    static func request(
        url urlString: String,
        method httpMethod: NetworkMethod,
        queryItems: [URLQueryItem]? = nil
    ) async throws -> [Any] {
        let url = URL(string: "https://api.tomorrow.io/v4/weather/\(urlString)")!
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        var defaultQueryItems: [URLQueryItem] = [URLQueryItem(name: "apikey", value: apiKey)]
        
        if let queryItems {
            defaultQueryItems.append(contentsOf: queryItems)
            defaultQueryItems.reverse()
        }
        components.queryItems = components.queryItems.map { $0 + defaultQueryItems } ?? defaultQueryItems
        
        var request = URLRequest(url: components.url!)
        print("URL: \(components.url!)")
        request.httpMethod = httpMethod.rawValue
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = ["Content-Type": "application/json"]
        
        let (data, _) = try await URLSession.shared.data(for: request)
        print(String(decoding: data, as: UTF8.self))
        
        return []
    }
    
    var requestLocationWeather: @Sendable (Location) async throws -> Void
}

extension DependencyValues {
    var weatherClient: WeatherClient {
        get { self[WeatherClient.self] }
        set { self[WeatherClient.self] = newValue }
    }
}

extension WeatherClient: DependencyKey {
    static let liveValue: WeatherClient = Self(
        requestLocationWeather: { location in
            let query = "\(location.latitude), \(location.longitude)"
            let _ = try await request(
                url: "forecast",
                method: .get,
                queryItems: [URLQueryItem(name: "location", value: query)]
            )
        }
    )
}
