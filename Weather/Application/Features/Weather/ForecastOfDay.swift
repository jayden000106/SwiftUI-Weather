//
//  ForecastOfDay.swift
//  Weather
//
//  Created by 정지혁 on 10/7/24.
//

import Charts
import SwiftUI

struct ForecastOfDay: View {
    private let isFirst: Bool
    private let dailyWeatherInterval: DailyWeatherInterval
    private let maxTempertureOfWeek: Double
    private let minTempertureOfWeek: Double
    
    private var range: CGFloat {
        return 80 / CGFloat(maxTempertureOfWeek - minTempertureOfWeek)
    }
    
    init(isFirst: Bool, dailyWeatherInterval: DailyWeatherInterval, maxTempertureOfWeek: Double, minTempertureOfWeek: Double) {
        self.isFirst = isFirst
        self.dailyWeatherInterval = dailyWeatherInterval
        self.maxTempertureOfWeek = maxTempertureOfWeek
        self.minTempertureOfWeek = minTempertureOfWeek
    }
    
    var body: some View {
        HStack {
            Text(isFirst ? "지금" : dailyWeatherInterval.weekdayText)
                .foregroundStyle(Color.white)
            Spacer()
            Image(systemName: dailyWeatherInterval.weatherIconText)
                .symbolRenderingMode(.multicolor)
            Spacer()
            HStack(spacing: 8) {
                Text("\(Int(dailyWeatherInterval.values.temperatureMin))°")
                    .foregroundStyle(Color.white.opacity(0.6))
                
                ZStack {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(.black.opacity(0.4))
                        .frame(height: 2)
                    
                    RoundedRectangle(cornerRadius: 4)
                        .foregroundStyle(
                            .linearGradient(
                                colors: [Color.green, Color.yellow],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(height: 2)
                        .padding(.leading, CGFloat((dailyWeatherInterval.values.temperatureMin - minTempertureOfWeek)) * range)
                        .padding(.trailing, CGFloat((maxTempertureOfWeek - dailyWeatherInterval.values.temperatureMax)) * range)
                }
                .frame(width: 80)
                
                Text("\(Int(dailyWeatherInterval.values.temperatureMax))°")
                    .foregroundStyle(Color.white)
            }
        }
        .padding(8)
    }
}

#Preview {
    VStack {
        ForecastOfDay(
            isFirst: true,
            dailyWeatherInterval: DailyWeatherInterval(
                startTime: "2024-11-13T11:00:00Z",
                values: DailyWeather(temperatureMin: -2.07, temperatureMax: 6.81, weatherCode: 1000)
            ),
            maxTempertureOfWeek: 25,
            minTempertureOfWeek: 11
        )
        ForecastOfDay(
            isFirst: false,
            dailyWeatherInterval: DailyWeatherInterval(
                startTime: "2024-11-14T11:00:00Z",
                values: DailyWeather(temperatureMin: -4.3, temperatureMax: 6.44, weatherCode: 1001)
            ),
            maxTempertureOfWeek: 25,
            minTempertureOfWeek: 11
        )
    }
    .background(Color.black)
}
