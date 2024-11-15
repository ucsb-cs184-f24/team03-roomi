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
            List (viewModel.userList) { user in
                ProfileCard(userInformation: user)
            }
            .onAppear { // Gets all users when the view is opened
                viewModel.getAllUsers()
            }
        }
    }
}

#Preview {
    SearchView()
        .environmentObject(AuthViewModel())
}
