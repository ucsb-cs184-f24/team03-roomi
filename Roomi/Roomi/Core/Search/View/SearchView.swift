//
//  SearchView.swift
//  Roomi
//
//  Created by Benjamin Conte on 10/26/24.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        NavigationView {
            if(viewModel.isLoading) {
                ProgressView()
            } else {
                List (viewModel.potentialUsers) { user in
                    ProfileCard(userInformation: user)
                }
            }
        }.refreshable {
            Task {
                await viewModel.getAllUsers()
            }
            viewModel.getAllPotentialUsers()
        }
    }
}

#Preview {
    SearchView()
        .environmentObject(AuthViewModel())
}
