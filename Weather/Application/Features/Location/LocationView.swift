//
//  LoctionView.swift
//  Weather
//
//  Created by 정지혁 on 9/30/24.
//

import SwiftUI

struct LocationView: View {
    @Binding private var selectedItem: Item?
    
    @State private var selection: Item
    
    private let initialItem: Item
    private let animation: Namespace.ID
    
    init(selectedItem: Binding<Item?>, initialItem: Item, animation: Namespace.ID) {
        self._selectedItem = selectedItem
        self.initialItem = initialItem
        self.animation = animation
        
        selection = initialItem
    }
    
    var body: some View {
        TabView(selection: $selection) {
            ForEach(items) { item in
                VStack {
                    Button {
                        withAnimation {
                            selectedItem = nil
                        }
                    } label: {
                        Text("Exit")
                            .foregroundColor(.red)
                    }
                    .padding(.top, 60)
                    
                    Text(item.title)
                        .foregroundColor(.white)
                    
                    Text(item.id.uuidString)
                        .foregroundColor(.white)
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .tag(item)
            }
        }
        .tabViewStyle(.page)
        .matchedGeometryEffect(id: initialItem.id, in: animation)
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    @Previewable @Namespace var animation
    LocationView(selectedItem: .constant(items.first), initialItem: items.first!, animation: animation)
}
