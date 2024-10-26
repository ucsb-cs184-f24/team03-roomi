//
//  ProfileView.swift
//  Roomi
//
//  Created by Anderson Lee on 10/19/24.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Profile")
                    .font(.largeTitle)
                
                Text("Email: \(String(describing: viewModel.currentUser?.email))")
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("Name: \(String(describing: viewModel.currentUser?.firstName)) \(String(describing: viewModel.currentUser?.lastName))")
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Button("Logout") {
                    viewModel.signOut()
                }
                .foregroundStyle(.red)
                .frame(maxHeight: .infinity, alignment: .bottom)
            }
            .padding()
            .frame(maxHeight: .infinity, alignment: .top)
        }
    }
}

#Preview {
    ProfileView()
        .environmentObject(AuthViewModel())
}
