//
//  Location.swift
//  Weather
//
//  Created by 정지혁 on 11/5/24.
//

struct Location: Identifiable, Hashable, Equatable {
    var id: String { name }
    
    var name: String
    var latitude: Double
    var longitude: Double
    var tag: String?
}

let dummyLocations = [
    Location(name: "서울", latitude: 134.2231, longitude: 53.4331, tag: "나의 위치"),
    Location(name: "대전", latitude: 132.2231, longitude: 53.4331),
]
