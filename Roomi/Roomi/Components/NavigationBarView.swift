//
//  NavigationBarView.swift
//  Roomi
//
//  Created by Anderson Lee on 10/22/24.
//

import SwiftUI

struct NavigationBarView: View {
    var body: some View {
        NavigationStack {
            HStack {
                NavigationLink {
                    ProfileView()
                        .navigationBarBackButtonHidden()
                } label: {
                    Text("Profile")
                }
                
                NavigationLink {
                    HomeView()
                        .navigationBarBackButtonHidden()
                } label: {
                    Text("Home")
                }
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
        }
    }
}

#Preview {
    NavigationBarView()
        .environmentObject(AuthViewModel())
}
