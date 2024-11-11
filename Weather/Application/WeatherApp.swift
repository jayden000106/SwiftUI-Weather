//
//  WeatherApp.swift
//  Weather
//
//  Created by 정지혁 on 9/23/24.
//

import SwiftUI

import ComposableArchitecture

@main
struct WeatherApp: App {
    var body: some Scene {
        WindowGroup {
            AppView(
                store: Store(initialState: AppReducer.State(locationList: LocationListReducer.State())) {
                    AppReducer()
                }
            )
        }
    }
}
