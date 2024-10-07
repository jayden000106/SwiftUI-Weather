//
//  PageController.swift
//  Weather
//
//  Created by 정지혁 on 9/30/24.
//

import SwiftUI

struct WeatherTabBar: View {
    @Binding private var selected: Int
    
    private let selections: [Int]
    
    init(selected: Binding<Int>, selections: [Int]) {
        self._selected = selected
        self.selections = selections
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
                ForEach(selections, id: \.self) { selection in
                    if selection == selections.first {
                        Image(systemName: "location.fill")
                            .font(.system(size: 10))
                            .foregroundStyle(selected == selection ? Color.tabBarSelected : Color.tabBarUnselected)
                    } else {
                        Circle()
                            .fill(selected == selection ? Color.tabBarSelected : Color.tabBarUnselected)
                            .frame(width: 8, height: 8)
                    }
                }
            }
            .animation(.easeInOut, value: selected)
            Spacer()
            Button {
                
            } label: {
                Image(systemName: "list.bullet")
                    .font(.title2)
                    .foregroundStyle(Color.white)
            }
        }
        .padding(.top, 16)
        .padding(.horizontal, 20)
        .overlay(alignment: .top) {
            Divider()
        }
    }
}

#Preview {
    WeatherTabBar(selected: .constant(0), selections: [0, 1, 2])
        .background(Color.black)
}

