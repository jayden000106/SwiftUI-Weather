//
//  SmallWeatherInfo.swift
//  Weather
//
//  Created by 정지혁 on 9/30/24.
//

import SwiftUI

struct SmallWeatherInfo: View {
    private let hourlyWeather: HourlyWeather
    
    init(hourlyWeather: HourlyWeather) {
        self.hourlyWeather = hourlyWeather
    }
    
    var body: some View {
        VStack(spacing: 16) {
            Text(hourlyWeather.time)
                .font(.footnote)
            Image(systemName: "cloud.moon.fill")
                .font(.title3)
            Text("\(hourlyWeather.temperture)°")
                .font(.title3)
        }
        .fontWeight(.semibold)
        .padding(12)
        .foregroundStyle(Color.font)
    }
}

#Preview {
    SmallWeatherInfo(
        hourlyWeather: HourlyWeather(
            time: "Now",
            weatherCode: 2,
            temperture: 21
        )
    )
    .background { Color.black }
}
