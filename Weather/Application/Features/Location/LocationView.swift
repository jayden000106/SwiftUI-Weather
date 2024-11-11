//
//  LoctionView.swift
//  Weather
//
//  Created by 정지혁 on 9/30/24.
//

import SwiftUI

import ComposableArchitecture

struct LocationView: View {
    @Bindable var store: StoreOf<LocationReducer>
    
    let animation: Namespace.ID
    let initialLocation: Location
    
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $store.selectedLocation) {
                ForEach(dummyLocations) { location in
                    WeatherView(location: location)
                        .tag(location)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            
            LocationTabBar(
                selected: store.selectedLocation,
                onTapList: {
                    store.send(.listTapped)
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
    LocationView(
        store: Store(initialState: LocationReducer.State(selectedLocation: dummyLocations.first!)) {
            LocationReducer()
        },
        animation: animation,
        initialLocation: dummyLocations.first!
    )
}
