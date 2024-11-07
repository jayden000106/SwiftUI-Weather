//
//  WeatherView.swift
//  Weather
//
//  Created by 정지혁 on 11/5/24.
//

import SwiftUI

struct WeatherView: View {
    private let location: Location
    
    init(location: Location) {
        self.location = location
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                header
                summary
                forecastsOfDay
            }
            .padding(.bottom)
        }
        .scrollIndicators(.hidden)
    }
}

private extension WeatherView {
    var header: some View {
        VStack(spacing: 2) {
            if let tag = location.tag {
                Text(tag)
                    .font(.caption)
                    .foregroundStyle(Color.font)
            }
            Text(location.name)
                .font(.largeTitle)
                .foregroundStyle(Color.font)
            Text(" 21°")
                .font(.system(size: 88, weight: .thin))
                .foregroundStyle(Color.font)
                .padding(.vertical, -12)
            Text("대체로 청명함")
                .font(.title3)
                .foregroundStyle(Color.white.opacity(0.4))
            Text("최고:19° 최저:1°")
                .font(.title3)
                .foregroundStyle(Color.font)
        }
        .padding(.vertical, 40)
    }
    
    var summary: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("오늘 밤 청명한 상태가 예상되며, 아침까지 이어지겠습니다.\n돌풍의 풍속은 최대 2m/s입니다.")
                .font(.footnote)
                .foregroundStyle(Color.font)
                .padding(16)
            WeatherDivider()
                .padding(.horizontal, 16)
            ScrollView(.horizontal) {
                HStack {
                    ForEach(dummyHourlyWeather, id: \.self) { hourlyWeather in
                        SmallWeatherInfo(hourlyWeather: hourlyWeather)
                    }
                }
                .padding(.horizontal, 16)
            }
            .scrollIndicators(.hidden)
            .padding(.bottom, 4)
        }
        .background {
            RoundedRectangle(cornerRadius: 16)
                .fill(.ultraThinMaterial.opacity(0.05))
        }
        .padding(.horizontal, 20)
    }
    
    var forecastsOfDay: some View {
        LazyVStack(alignment: .leading, spacing: 4) {
            HStack(spacing: 4) {
                Image(systemName: "calendar")
                Text("10일간의 일기예보")
            }
            .font(.caption)
            .foregroundStyle(Color.white.opacity(0.4))
            .padding(.bottom, 4)
            
            ForEach(dummyDailyWeather, id: \.self) { dailyWeather in
                VStack(spacing: 4) {
                    WeatherDivider()
                    ForecastOfDay(
                        dailyWeather: dailyWeather,
                        minTempertureOfWeek: dummyDailyWeather.map { $0.minTemperture }.min() ?? 0,
                        maxTempertureOfWeek: dummyDailyWeather.map { $0.maxTemperture }.max() ?? 100
                    )
                }
            }
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 16)
                .fill(.ultraThinMaterial.opacity(0.05))
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    WeatherView(location: dummyLocations.first!)
        .background(Color.black.ignoresSafeArea())
}
