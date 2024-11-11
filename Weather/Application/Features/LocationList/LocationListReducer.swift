//
//  LocationListReducer.swift
//  Weather
//
//  Created by 정지혁 on 11/5/24.
//

import Foundation

import ComposableArchitecture

@Reducer
struct LocationListReducer {
    @ObservableState
    struct State {
        var searchText = ""
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case locationTapped(Location)
        case clearTapped
    }
    
    var body: some Reducer<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .locationTapped(let location):
                print("LocationListReducer: \(location.id)")
                return .none
            case .clearTapped:
                state.searchText = ""
                return .none
            default:
                return .none
            }
        }
    }
}