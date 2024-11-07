//
//  LocationListView.swift
//  Weather
//
//  Created by 정지혁 on 11/5/24.
//

import SwiftUI

struct LocationListView: View {
    @Binding private var selectedLocation: Location?
    
    @State private var searchText = ""
    
    private let animation: Namespace.ID
    
    init(selectedLocation: Binding<Location?>, animation: Namespace.ID) {
        self._selectedLocation = selectedLocation
        self.animation = animation
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                toolbar
                header
                searchBar
                locationList
                caption
            }
            .padding(16)
        }
        .scrollIndicators(.hidden)
        .scrollDisabled(true)
    }
}

private extension LocationListView {
    var toolbar: some View {
        HStack {
            Spacer()
            Button {
                
            } label: {
                Image(systemName: "ellipsis.circle")
            }
            .font(.title3)
            .foregroundStyle(.primary)
        }
    }
    
    var header: some View {
        Text("날씨")
            .font(.largeTitle)
            .fontWeight(.bold)
    }
    
    var searchBar: some View {
        HStack(spacing: 4) {
            Image(systemName: "magnifyingglass")
            TextField("도시 또는 공항 검색", text: $searchText)
            if !searchText.isEmpty {
                Button {
                    searchText = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                }
            }
        }
        .foregroundStyle(.secondary)
        .padding(.vertical, 4)
        .padding(.horizontal, 8)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.secondarySystemBackground))
        )
    }
    
    var locationList: some View {
        VStack {
            ForEach(dummyLocations) { location in
                LocationListItem(location: location)
                    .matchedGeometryEffect(id: location.id, in: animation)
                    .onTapGesture {
                        withAnimation {
                            selectedLocation = location
                        }
                    }
            }
        }
    }
    
    var caption: some View {
        HStack(spacing: 0) {
            Spacer()
            Button {
                
            } label: {
                Text("날씨 데이터")
                    .underline()
            }
            Text(" 및 ")
            Button {
                
            } label: {
                Text("지도 데이터")
                    .underline()
            }
            Text("에 관하여 더 알아보기")
            Spacer()
        }
        .font(.caption2)
        .foregroundStyle(Color.secondary)
    }
}

#Preview {
    @Previewable @Namespace var animation
    LocationListView(selectedLocation: .constant(nil), animation: animation)
}
