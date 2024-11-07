//
//  LoctionView.swift
//  Weather
//
//  Created by 정지혁 on 9/30/24.
//

import SwiftUI

struct LocationView: View {
    @Binding private var selectedLocation: Location?
    
    @State private var selection: Location
    
    private let animation: Namespace.ID
    private let initialLocation: Location
    
    init(selectedLocation: Binding<Location?>, initialLocation: Location, animation: Namespace.ID) {
        self._selectedLocation = selectedLocation
        self.animation = animation
        self.initialLocation = initialLocation
        selection = initialLocation
    }
    
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $selection) {
                ForEach(dummyLocations) { location in
                    WeatherView(location: location)
                        .tag(location)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            
            LocationTabBar(
                selected: $selection,
                selections: dummyLocations,
                onTapList: {
                    withAnimation {
                        selectedLocation = nil
                    }
                }
            )
        }
        .matchedGeometryEffect(id: initialLocation.id, in: animation)
        .background {
            Image("MainBackground")
                .resizable()
                .ignoresSafeArea()
        }
    }
}

#Preview {
    @Previewable @Namespace var animation
    LocationView(selectedLocation: .constant(dummyLocations.first!), initialLocation: dummyLocations.first!, animation: animation)
}
