//
//  ForecastOfDay.swift
//  Weather
//
//  Created by 정지혁 on 10/7/24.
//

import Charts
import SwiftUI

struct ForecastOfDay: View {
    private let weekday: String
    private let weatherCode: Int
    private let minTemperture: Int
    private let maxTemperture: Int
    private let minTempertureOfWeek: Int
    private let maxTempertureOfWeek: Int
    
    init(
        weekday: String,
        weatherCode: Int,
        minTemperture: Int,
        maxTemperture: Int,
        minTempertureOfWeek: Int,
        maxTempertureOfWeek: Int
    ) {
        self.weekday = weekday
        self.weatherCode = weatherCode
        self.minTemperture = minTemperture
        self.maxTemperture = maxTemperture
        self.minTempertureOfWeek = minTempertureOfWeek
        self.maxTempertureOfWeek = maxTempertureOfWeek
    }
    
    var body: some View {
        HStack {
            Text(weekday)
                .foregroundStyle(Color.white)
            Spacer()
            Image(systemName: "cloud.fill")
                .foregroundStyle(Color.white)
            Spacer()
            HStack(spacing: 8) {
                Text("\(minTemperture)°")
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
                        .padding(.leading)
                        .padding(.trailing)
                }
                .frame(width: 80)
                
                Text("\(maxTemperture)°")
                    .foregroundStyle(Color.white)
            }
        }
        .padding(8)
    }
}

#Preview {
    ForecastOfDay(
        weekday: "오늘",
        weatherCode: 3,
        minTemperture: 12,
        maxTemperture: 22,
        minTempertureOfWeek: 11,
        maxTempertureOfWeek: 24
    )
    .background(Color.black)
}
