//
//  AppReducer.swift
//  Weather
//
//  Created by 정지혁 on 11/4/24.
//

import SwiftUI

import ComposableArchitecture

@Reducer
struct AppReducer {
    @ObservableState
    struct State {
        var locationList: LocationListReducer.State
        var location: LocationReducer.State?
    }
    
    enum Action {
        case locationList(LocationListReducer.Action)
        case location(LocationReducer.Action)
    }
    
    var body: some Reducer<State, Action> {
        Scope(state: \.locationList, action: \.locationList) {
            LocationListReducer()
        }
        Reduce { state, action in
            switch action {
            case .locationList(let action):
                switch action {
                case .locationTapped(let location):
                    print("AppReducer: \(location.id)")
                    withAnimation(.easeInOut(duration: 0.5)) {
                        state.location = LocationReducer.State(selectedLocation: location)
                    }
                    return .none
                default:
                    return .none
                }
            case .location(let action):
                switch action {
                case .listTapped:
                    print("AppReducer: List Tapped")
                    withAnimation(.easeInOut(duration: 0.5)) {
                        state.location = nil
                    }
                    return .none
                default:
                    return .none
                }
            }
        }
        .ifLet(\.location, action: \.location) {
            LocationReducer()
        }
    }
}
