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
        .edgesIgnoringSafeArea(.top)
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
            Text(" \(Int(location.realtimeWeather?.temperature ?? 20))°")
                .font(.system(size: 88, weight: .thin))
                .foregroundStyle(Color.font)
                .padding(.vertical, -12)
            Text(location.realtimeWeather?.weatherText ?? "")
                .font(.title3)
                .foregroundStyle(Color.white.opacity(0.4))
            Text("최고:\(Int(location.dailyWeatherIntervals?.first?.values.temperatureMax ?? 20))° 최저:\(Int(location.dailyWeatherIntervals?.first?.values.temperatureMin ?? 0))°")
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
                    ForEach(location.hourlyWeatherIntervals ?? [], id: \.self) { interval in
                        SmallWeatherInfo(
                            isFirst: interval == location.hourlyWeatherIntervals?.first,
                            hourlyWeatherInterval: interval
                        )
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
            
            ForEach(location.dailyWeatherIntervals ?? [], id: \.self) { interval in
                VStack(spacing: 4) {
                    WeatherDivider()
                    ForecastOfDay(
                        isFirst: interval == location.dailyWeatherIntervals?.first,
                        dailyWeatherInterval: interval,
                        maxTempertureOfWeek: location.maxTempertureOfWeek,
                        minTempertureOfWeek: location.minTempertureOfWeek
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
