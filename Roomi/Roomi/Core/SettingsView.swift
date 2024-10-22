//
//  SettingsView.swift
//  Roomi
//
//  Created by Benjamin Conte on 10/17/24.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack {
            Text("Profile")
            Text(viewModel.userSession?.email ?? "No Email")
            
            Button {
                Task {
                    try viewModel.signOut()
                }
            } label: {
                Text("Log Out")
            }
            
            Button {
                Task {
                    try await viewModel.deleteAccount()
                }
            } label: {
                Text("Delete Account")
            }
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(AuthViewModel())
}
