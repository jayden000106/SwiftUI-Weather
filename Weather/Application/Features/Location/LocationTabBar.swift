//
//  LocationTabBar.swift
//  Weather
//
//  Created by 정지혁 on 11/8/24.
//

import SwiftUI

struct LocationTabBar: View {
    private let selected: Location
    private let selections: [Location]
    private let onTapList: () -> Void
    
    init(selected: Location, selections: [Location], onTapList: @escaping () -> Void) {
        self.selected = selected
        self.selections = selections
        self.onTapList = onTapList
    }
    
    var body: some View {
        HStack {
            Button {
                
            } label: {
                Image(systemName: "map")
                    .font(.title2)
                    .foregroundStyle(Color.white)
            }
            Spacer()
            HStack(spacing: 8) {
                ForEach(selections, id: \.self) { location in
                    if location == selections.first {
                        Image(systemName: "location.fill")
                            .font(.system(size: 10))
                            .foregroundStyle(selected == location ? Color.tabBarSelected : Color.tabBarUnselected)
                    } else {
                        Circle()
                            .fill(selected == location ? Color.tabBarSelected : Color.tabBarUnselected)
                            .frame(width: 8, height: 8)
                    }
                }
            }
            .animation(.easeInOut, value: selected)
            Spacer()
            Button {
                onTapList()
            } label: {
                Image(systemName: "list.bullet")
                    .font(.title2)
                    .foregroundStyle(Color.white)
            }
        }
        .padding(.top, 16)
        .padding(.horizontal, 20)
        .overlay(alignment: .top) {
            WeatherDivider()
        }
    }
}

#Preview {
    LocationTabBar(
        selected: dummyLocations.first!,
        selections: dummyLocations,
        onTapList: {}
    )
    .background(Color.black)
}
