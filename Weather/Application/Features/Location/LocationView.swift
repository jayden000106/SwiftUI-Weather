//
//  LoctionView.swift
//  Weather
//
//  Created by 정지혁 on 9/30/24.
//

import SwiftUI

struct LocationView: View {
    @Binding private var selectedLocation: Location?
    
    @State private var selection: Location
    
    private let animation: Namespace.ID
    private let initialLocation: Location
    
    init(selectedLocation: Binding<Location?>, initialLocation: Location, animation: Namespace.ID) {
        self._selectedLocation = selectedLocation
        self.animation = animation
        self.initialLocation = initialLocation
        selection = initialLocation
    }
    
    var body: some View {
        TabView(selection: $selection) {
            ForEach(dummyLocations) { location in
                VStack {
                    Button {
                        withAnimation {
                            selectedLocation = nil
                        }
                    } label: {
                        Text("Exit")
                            .foregroundColor(.red)
                    }
                    .padding(.top, 60)
                    
                    Text(location.name)
                        .foregroundColor(.white)
                    
                    Text(location.id)
                        .foregroundColor(.white)
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .tag(location)
            }
        }
        .tabViewStyle(.page)
        .matchedGeometryEffect(id: initialLocation.id, in: animation)
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    @Previewable @Namespace var animation
    LocationView(selectedLocation: .constant(dummyLocations.first!), initialLocation: dummyLocations.first!, animation: animation)
}
