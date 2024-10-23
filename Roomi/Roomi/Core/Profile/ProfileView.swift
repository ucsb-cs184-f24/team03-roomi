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
        if let user = viewModel.currentUser {
            NavigationStack {
                Text("Profile")
                    .font(.largeTitle)
                
                VStack {
                    Text("Email: \(user.email)")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Name: \(user.firstName) \(user.lastName)")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding()
                .frame(maxHeight: .infinity, alignment: .top)
                
                NavigationBarView()
            }
        }
    }
}

#Preview {
    ProfileView()
        .environmentObject(AuthViewModel())
}
