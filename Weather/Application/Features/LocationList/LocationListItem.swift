//
//  LocationListItem.swift
//  Weather
//
//  Created by 정지혁 on 11/5/24.
//

import SwiftUI

struct LocationListItem: View {
    private let location: Location
    
    init(location: Location) {
        self.location = location
    }
    
    var body: some View {
        VStack(spacing: 20) {
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text(location.name)
                        .font(.title2)
                        .fontWeight(.bold)
                        .shadow(radius: 2)
                    Text(location.tag ?? "")
                        .foregroundStyle(Color.white.opacity(0.8))
                        .font(.caption2)
                }
                Spacer()
                Text("10°")
                    .font(.largeTitle)
                    .shadow(radius: 2)
            }
            HStack {
                Text("대체로 청명함")
                Spacer()
                Text("최고: 13° 최저: 0°")
            }
            .font(.caption2)
            .foregroundStyle(Color.white.opacity(0.8))
        }
        .padding(12)
        .foregroundStyle(Color.white)
        .background {
            GeometryReader { geometry in
                Image("ListBackground")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        }
    }
}

#Preview {
    LocationListItem(location: dummyLocations.first!)
}
