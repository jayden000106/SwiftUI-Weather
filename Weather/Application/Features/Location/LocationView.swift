//
//  LoctionView.swift
//  Weather
//
//  Created by 정지혁 on 9/30/24.
//

import SwiftUI

struct LocationView: View {
    @Binding private var selectedItem: Item?
    
    let animation: Namespace.ID
    
    init(selectedItem: Binding<Item?>, animation: Namespace.ID) {
        _selectedItem = selectedItem
        self.animation = animation
    }
    
    var body: some View {
        if let selectedItem = selectedItem {
            TabView(selection: $selectedItem) {
                ForEach(items) { item in
                    VStack {
                        Button {
                            withAnimation {
                                self.selectedItem = nil
                            }
                        } label: {
                            Text("Exit")
                                .foregroundColor(.white)
                        }
                        .padding(.top, 60)
                        
                        Text(selectedItem.title)
                            .foregroundColor(.white)
                        
                        Text(selectedItem.id.uuidString)
                            .foregroundColor(.white)
                        
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .tag(item)
                }
            }
            .tabViewStyle(.page)
            .matchedGeometryEffect(id: selectedItem.id, in: animation)
            .edgesIgnoringSafeArea(.all)
        }
    }
}

#Preview {
    @Previewable @Namespace var animation
    LocationView(selectedItem: .constant(items.first), animation: animation)
}
