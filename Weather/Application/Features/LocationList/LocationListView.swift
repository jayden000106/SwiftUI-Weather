//
//  LocationListView.swift
//  Weather
//
//  Created by 정지혁 on 11/5/24.
//

import SwiftUI

struct LocationListView: View {
    @Binding private var selectedItem: Item?
    
    private let animation: Namespace.ID
    
    init(selectedItem: Binding<Item?>, animation: Namespace.ID) {
        self._selectedItem = selectedItem
        self.animation = animation
    }
    
    var body: some View {
        LazyVStack(spacing: 8) {
            ForEach(items) { item in
                VStack {
                    HStack {
                        Text(item.title)
                        Spacer()
                        Text(item.id.uuidString)
                    }
                    .padding()
                }
                .background(Color.red)
                .matchedGeometryEffect(id: item.id, in: animation)
                .onTapGesture {
                    withAnimation {
                        selectedItem = item
                    }
                }
            }
        }
    }
}

#Preview {
    @Previewable @Namespace var animation
    LocationListView(selectedItem: .constant(nil), animation: animation)
}
