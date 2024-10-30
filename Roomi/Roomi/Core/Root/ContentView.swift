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
                            Label("Search", systemImage: "magnifyingglass")
                        }
                    
                    ProfileView()
                        .tabItem {
                            Label("Profile", systemImage: "person.circle")
                        }
                    
                    NavigationView
                    {
                        ChatListView()
                    }.tabItem
                    {Label("Messages", systemImage: "message.fill")}
                }
            }
            else {
                if viewModel.loginState == true {
                    LoginView()
                }
                else {
                    SignUpView()
                }
                            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AuthViewModel())
}
