//
//  SmallWeatherInfo.swift
//  Weather
//
//  Created by 정지혁 on 9/30/24.
//

import SwiftUI

struct SmallWeatherInfo: View {
    private let time: String
    private let weatherCode: Int
    private let temperture: Int
    
    init(time: String, weatherCode: Int, temperture: Int) {
        self.time = time
        self.weatherCode = weatherCode
        self.temperture = temperture
    }
    
    var body: some View {
        VStack(spacing: 16) {
            Text(time)
                .font(.body)
            Image(systemName: "cloud.moon.fill")
                .font(.title3)
            Text("\(temperture)°")
                .font(.title3)
        }
        .padding(12)
        .foregroundStyle(Color.font)
    }
}

#Preview {
    SmallWeatherInfo(time: "Now", weatherCode: 2, temperture: 21)
        .background { Color.black }
}
