//
//  LocationReducer.swift
//  Weather
//
//  Created by 정지혁 on 11/11/24.
//

import Foundation

import ComposableArchitecture

@Reducer
struct LocationReducer {
    @ObservableState
    struct State {
        var selectedLocation: Location
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case listTapped
    }
    
    var body: some Reducer<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .listTapped:
                print("List Button Tapped")
                return .none
            default:
                return .none
            }
        }
    }
}
