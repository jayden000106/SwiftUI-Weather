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
            VStack(spacing: 32) {
                header
                summary
            }
            .padding(.vertical, 40)
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
    }
    
    var summary: some View {
        VStack(spacing: 0) {
            Text("Cloudy conditions from 1AM-9AM, with showers expected at 9AM.")
                .font(.body)
                .foregroundStyle(Color.font)
                .padding(16)
            Rectangle()
                .fill(Color.tabBarDivier)
                .frame(height: 1)
                .padding(.horizontal, 16)
            ScrollView(.horizontal) {
                HStack {
                    ForEach(0...12, id: \.self) { index in
                        SmallWeatherInfo(time: index == 0 ? "Now" : "\(index)PM", weatherCode: 3, temperture: 21)
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
        .padding(20)
    }
}

#Preview {
    LocationView()
        .background(Color.black)
}
