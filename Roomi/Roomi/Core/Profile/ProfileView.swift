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
                if let user = viewModel.currentUser {
                
                    Text("Profile")
                        .font(.largeTitle)
                    
                    Text("Email: \(user.email)")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Name: \(user.name)")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Button("Logout") {
                        viewModel.signOut()
                    }
                    .foregroundStyle(.red)
                    .frame(maxHeight: .infinity, alignment: .bottom)
                }
                else {
                    Text("Not logged in")
                }
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
