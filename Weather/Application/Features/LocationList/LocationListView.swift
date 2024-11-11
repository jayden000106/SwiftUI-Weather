//
//  LocationListView.swift
//  Weather
//
//  Created by 정지혁 on 11/5/24.
//

import SwiftUI

import ComposableArchitecture

struct LocationListView: View {
    @Bindable var store: StoreOf<LocationListReducer>
    
    let animation: Namespace.ID
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            toolbar
            header
            searchBar
            locationList
            caption
            Spacer()
        }
        .padding(16)
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
            TextField("도시 또는 공항 검색", text: $store.searchText)
            if !store.searchText.isEmpty {
                Button {
                    store.send(.clearTapped)
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
        VStack(spacing: 8) {
            ForEach(dummyLocations) { location in
                LocationListItem(location: location)
                    .matchedGeometryEffect(id: location.id, in: animation)
                    .onTapGesture {
                        store.send(.locationTapped(location))
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
    LocationListView(
        store: Store(initialState: LocationListReducer.State()) { LocationListReducer() },
        animation: animation
    )
}
