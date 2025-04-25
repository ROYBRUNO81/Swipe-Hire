//
//  SearchView.swift
//  SwipeHire
//
//  Created by Bruno Ndiba Mbwaye Roy on 4/24/25.
//

import SwiftUI

/// Search bar and location-filter toggle.
struct SearchView: View {
    @ObservedObject var viewModel: AppViewModel
    @State private var query = ""
    @State private var filterStateOnly = false

    var body: some View {
        HStack(spacing: 12) {
            TextField("Search by title or location…", text: $query)
                .textFieldStyle(.roundedBorder)
                .foregroundColor(.black)

            Button("OK") {
                viewModel.applyFilters(query: query, stateOnly: filterStateOnly)
            }
            .buttonStyle(.bordered)

            Button {
                filterStateOnly.toggle()
                viewModel.applyFilters(query: query, stateOnly: filterStateOnly)
            } label: {
                Image(systemName: filterStateOnly ? "mappin" : "mappin.circle")
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal)
    }
}
