//
//  NavigationBarView.swift
//  Roomi
//
//  Created by Anderson Lee on 10/22/24.
//

import SwiftUI

struct NavigationBarView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.circle")
                }
        }
    }
}

#Preview {
    NavigationBarView()
        .environmentObject(AuthViewModel())
}
