//
//  AppView.swift
//  Weather
//
//  Created by 정지혁 on 11/4/24.
//

import SwiftUI

struct AppView: View {
    @Namespace private var animation
    @State private var selectedItem: Item? = nil

    var body: some View {
        ZStack {
            LocationListView(selectedItem: $selectedItem, animation: animation)
                .opacity(selectedItem == nil ? 1 : 0)
                .animation(.easeInOut, value: selectedItem)
            
            if selectedItem != nil {
                LocationView(selectedItem: $selectedItem, animation: animation)
            }
        }
    }
}

struct ItemView: View {
    let item: Item
    
    var body: some View {
        VStack {
            Text(item.title)
                .font(.largeTitle)
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 200)
        .background(Color.blue)
        .cornerRadius(10)
        .padding()
    }
}

struct Item: Identifiable, Equatable, Hashable {
    let id = UUID()
    let title: String
}

let items = [
    Item(title: "아이템 1"),
    Item(title: "아이템 2"),
    Item(title: "아이템 3"),
    // 추가 아이템...
]

#Preview {
    AppView()
}
