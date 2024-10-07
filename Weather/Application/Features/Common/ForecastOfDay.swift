//
//  ForecastOfDay.swift
//  Weather
//
//  Created by 정지혁 on 10/7/24.
//

import Charts
import SwiftUI

struct ForecastOfDay: View {
    private let dailyWeather: DailyWeather
    private let minTempertureOfWeek: Int
    private let maxTempertureOfWeek: Int
    
    private var range: CGFloat {
        return 80 / CGFloat(maxTempertureOfWeek - minTempertureOfWeek)
    }
    
    init(
        dailyWeather: DailyWeather,
        minTempertureOfWeek: Int,
        maxTempertureOfWeek: Int
    ) {
        self.dailyWeather = dailyWeather
        self.minTempertureOfWeek = minTempertureOfWeek
        self.maxTempertureOfWeek = maxTempertureOfWeek
    }
    
    var body: some View {
        HStack {
            Text(dailyWeather.weekday)
                .foregroundStyle(Color.white)
            Spacer()
            Image(systemName: "cloud.fill")
                .foregroundStyle(Color.white)
            Spacer()
            HStack(spacing: 8) {
                Text("\(dailyWeather.minTemperture)°")
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
                        .padding(.leading, CGFloat((dailyWeather.minTemperture - minTempertureOfWeek)) * range)
                        .padding(.trailing, CGFloat((maxTempertureOfWeek - dailyWeather.maxTemperture)) * range)
                }
                .frame(width: 80)
                
                Text("\(dailyWeather.maxTemperture)°")
                    .foregroundStyle(Color.white)
            }
        }
        .padding(8)
    }
}

#Preview {
    ForecastOfDay(
        dailyWeather: DailyWeather(
            weekday: "오늘",
            weatherCode: 3,
            minTemperture: 12,
            maxTemperture: 24
        ),
        minTempertureOfWeek: 11,
        maxTempertureOfWeek: 25
    )
    .background(Color.black)
}
