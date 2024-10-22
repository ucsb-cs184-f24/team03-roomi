//
//  ContentView.swift
//  Roomi
//
//  Created by Alec Morrison on 10/11/24.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MainViewViewModel()
    
    var body: some View {
        if viewModel.isSignedIn, !viewModel.currentUserId.isEmpty {
            // signed in state
            TabView {
                SwipeStack()
                    .tabItem {
                        Label("Home",systemImage: "house")
                    }
                Profile()
                    .tabItem {
                        Label("Profile",systemImage: "person.circle")
                    }
            }
            
        } else {
            LoginView()
        }
        
        
    }
}

#Preview {
    MainView()
}
