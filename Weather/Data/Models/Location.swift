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
    Location(name: "서울", latitude: 126.9779692, longitude: 37.566535, tag: "나의 위치"),
    Location(name: "대전", latitude: 127.3845475, longitude: 36.3504119),
]
