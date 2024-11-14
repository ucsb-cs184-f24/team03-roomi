//
//  SearchView.swift
//  Roomi
//
//  Created by Benjamin Conte on 10/26/24.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var searchViewModel: SearchViewModel

    var body: some View {
        NavigationView {
            List (searchViewModel.potentialUsers) { user in
                ProfileCard(userInformation: user)
            }
        }
        .onAppear {
            Task {
                await searchViewModel.getAllUsers()
            }
            searchViewModel.getAllPotentialUsers()
        }
        .refreshable {
            Task {
                await searchViewModel.getAllUsers()
            }
            searchViewModel.getAllPotentialUsers()
        }
    }
}

#Preview {
    SearchView()
        .environmentObject(SearchViewModel())
}
