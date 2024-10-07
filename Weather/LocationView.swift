//
//  LoctionView.swift
//  Weather
//
//  Created by 정지혁 on 9/30/24.
//

import SwiftUI

struct LocationView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                header
                summary
                forecastsOfDay
            }
        }
        .scrollIndicators(.hidden)
    }
}

private extension LocationView {
    var header: some View {
        VStack(spacing: 2) {
            Text("Seongnam-si")
                .font(.largeTitle)
                .foregroundStyle(Color.font)
            Text(" 21°")
                .font(.system(size: 88, weight: .thin))
                .foregroundStyle(Color.font)
                .padding(.vertical, -12)
            Text("Partly Cloudy")
                .font(.title3)
                .foregroundStyle(Color.font)
            Text("H:29° L:15°")
                .font(.title3)
                .foregroundStyle(Color.font)
        }
        .padding(.vertical, 40)
    }
    
    var summary: some View {
        VStack(spacing: 0) {
            Text("Cloudy conditions from 1AM-9AM, with showers expected at 9AM.")
                .font(.body)
                .foregroundStyle(Color.font)
                .padding(16)
            Divider()
                .padding(.horizontal, 16)
            ScrollView(.horizontal) {
                HStack {
                    ForEach(0...12, id: \.self) { index in
                        SmallWeatherInfo(
                            time: index == 0 ? "Now" : "\(index)PM",
                            weatherCode: 3,
                            temperture: 21
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
            
            ForEach(0..<10, id: \.self) { index in
                Divider()
                ForecastOfDay(
                    weekday: "오늘",
                    weatherCode: 3,
                    minTemperture: 12,
                    maxTemperture: 23,
                    minTempertureOfWeek: 11,
                    maxTempertureOfWeek: 24
                )
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
    LocationView()
        .background(Color.black)
}
