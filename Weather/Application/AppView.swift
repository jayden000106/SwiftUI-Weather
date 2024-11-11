//
//  AppView.swift
//  Weather
//
//  Created by 정지혁 on 11/4/24.
//

import SwiftUI

import ComposableArchitecture

struct AppView: View {
    @Bindable var store: StoreOf<AppReducer>
    
    @Namespace private var animation
    
    var body: some View {
        if let locationStore = store.scope(state: \.location, action: \.location) {
            LocationView(
                store: locationStore,
                animation: animation,
                initialLocation: locationStore.selectedLocation
            )
        } else {
            LocationListView(
                store: store.scope(state: \.locationList, action: \.locationList),
                animation: animation
            )
        }
    }
}

#Preview {
    AppView(
        store: Store(
            initialState: AppReducer.State(locationList: LocationListReducer.State())
        ) {
            AppReducer()
        }
    )
}
