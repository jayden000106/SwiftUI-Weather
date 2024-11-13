//
//  SmallWeatherInfo.swift
//  Weather
//
//  Created by 정지혁 on 9/30/24.
//

import SwiftUI

struct SmallWeatherInfo: View {
    private let isFirst: Bool
    private let hourlyWeatherInterval: HourlyWeatherInterval
    
    init(isFirst: Bool, hourlyWeatherInterval: HourlyWeatherInterval) {
        self.isFirst = isFirst
        self.hourlyWeatherInterval = hourlyWeatherInterval
    }
    
    var body: some View {
        VStack(spacing: 16) {
            Text(isFirst ? "지금" : "\(hourlyWeatherInterval.hour)시")
                .font(.footnote)
            Image(systemName: hourlyWeatherInterval.weatherIconText)
                .symbolRenderingMode(.multicolor)
                .font(.title3)
                .frame(width: 16, height: 16)
            Text("\(Int(hourlyWeatherInterval.values.temperature))°")
                .font(.title3)
        }
        .fontWeight(.semibold)
        .padding(12)
        .foregroundStyle(Color.font)
    }
}

#Preview {
    VStack {
        SmallWeatherInfo(
            isFirst: true,
            hourlyWeatherInterval: HourlyWeatherInterval(
                startTime: "2024-11-13T16:00:00Z",
                values: HourlyWeather(temperature: 12, weatherCode: 1000)
            )
        )
        SmallWeatherInfo(
            isFirst: false,
            hourlyWeatherInterval: HourlyWeatherInterval(
                startTime: "2024-11-13T17:00:00Z",
                values: HourlyWeather(temperature: 14, weatherCode: 1100)
            )
        )
    }
    .background { Color.black }
}
