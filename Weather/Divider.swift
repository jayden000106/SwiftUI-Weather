//
//  Divider.swift
//  Weather
//
//  Created by 정지혁 on 10/7/24.
//

import SwiftUI

struct Divider: View {
    var body: some View {
        Rectangle()
            .fill(Color.tabBarDivier)
            .frame(height: 1)
    }
}

#Preview {
    Divider()
}