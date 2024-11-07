//
//  AppView.swift
//  Weather
//
//  Created by 정지혁 on 11/4/24.
//

import SwiftUI

struct AppView: View {
    @Namespace private var animation
    
    @State private var selectedLocation: Location? = dummyLocations.first
    
    var body: some View {
        if let selectedLocation = selectedLocation {
            LocationView(selectedLocation: $selectedLocation, initialLocation: selectedLocation, animation: animation)
        } else {
            LocationListView(selectedLocation: $selectedLocation, animation: animation)
        }
    }
}

#Preview {
    AppView()
}
