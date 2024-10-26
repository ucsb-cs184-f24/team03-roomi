//
//  ContentView.swift
//  Roomi
//
//  Created by Alec Morrison on 10/11/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        Group {
            if viewModel.userSession != nil {
                TabView {
                    HomeView()
                        .tabItem {
                            Label("Home", systemImage: "house")
                        }
                    
                    SearchView()
                        .tabItem {
                            Label ("Profiles", systemImage: "person.circle")
                        }
                    
                    ProfileView()
                        .tabItem {
                            Label ("My Profile", systemImage: "person.crop.circle")
                        }
                }
            }
            else {
                LoginView()
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AuthViewModel())
}
