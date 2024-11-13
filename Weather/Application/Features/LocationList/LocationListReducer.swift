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
        var locations = [
            Location(name: "서울", latitude: 37.566535, longitude: 126.9779692, tag: "나의 위치"),
            Location(name: "대전", latitude: 36.3504119, longitude: 127.3845475)
        ]
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case onAppear
        case weatherResponse(Result<[LocationWeatherData], Error>)
        case locationTapped(Location)
        case clearTapped
    }
    
    @Dependency(\.weatherClient) private var weatherClient
    
    var body: some Reducer<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .weatherResponse(.success(let weatherData)):
                print("LocationListReducer: Success")
                for index in weatherData.indices {
                    state.locations[index].realtimeWeather = weatherData[index].realtimeWeather
                    state.locations[index].hourlyWeatherIntervals = weatherData[index].hourlyWeatherIntervals
                }
                return .none
            case .weatherResponse(.failure(let error)):
                print("LocationListReducer: Failure \(error.localizedDescription)")
                // TODO: Error Handling
                return .none
            case .onAppear:
                let locations = state.locations
                return .run { send in
                    await send(.weatherResponse(Result {
                        var result: [LocationWeatherData] = []
                        for location in locations {
                            let realtimeWeatherDTO = try await weatherClient.requestLocationRealtime(location)
                            let hourlyWeatherDTO = try await weatherClient.requestLocationHourlyTimelines(location)
                            result.append(
                                LocationWeatherData(
                                    realtimeWeather: realtimeWeatherDTO.data.values,
                                    hourlyWeatherIntervals: hourlyWeatherDTO.data.timelines.first?.intervals ?? []
                                )
                            )
                        }
                        return result
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
