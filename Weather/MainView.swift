//
//  ContentView.swift
//  Weather
//
//  Created by 정지혁 on 9/23/24.
//

import SwiftUI

struct MainView: View {
    @State private var selectedTab = 0
    
    private let tabs = [0, 1]
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Text("1")
                .tag(0)
            Text("2")
                .tag(1)
        }
        .font(.headline)
        .tabViewStyle(.page(indexDisplayMode: .never))
        .overlay(alignment: .bottom) {
            WeatherTabBar(selected: $selectedTab, selections: tabs)
                .padding(.bottom, 8)
        }
        .background {
            Image("MainBackground")
                .resizable()
                .ignoresSafeArea()
        }
    }
}

#Preview {
    MainView()
}