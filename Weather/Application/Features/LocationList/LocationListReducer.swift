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
        case onAppear
        case forecastResponse(Result<Void, Error>)
        case locationTapped(Location)
        case clearTapped
    }
    
    @Dependency(\.weatherClient) private var weatherClient
    
    var body: some Reducer<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .forecastResponse(.success):
                print("LocationListReducer: Success")
                return .none
            case .forecastResponse(.failure(let error)):
                print("LocationListReducer: Failure \(error.localizedDescription)")
                return .none
            case .onAppear:
                return .run { send in
                    await send(.forecastResponse(Result {
                        try await weatherClient.requestLocationWeather(dummyLocations.first!)
                    }))
                }
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
