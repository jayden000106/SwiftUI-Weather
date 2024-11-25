//
//  WeatherWidgetBundle.swift
//  WeatherWidget
//
//  Created by 정지혁 on 11/25/24.
//

import WidgetKit
import SwiftUI

@main
struct WeatherWidgetBundle: WidgetBundle {
    var body: some Widget {
        WeatherWidget()
        WeatherWidgetControl()
        WeatherWidgetLiveActivity()
    }
}
