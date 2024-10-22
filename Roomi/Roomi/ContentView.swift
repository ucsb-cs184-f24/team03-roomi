//
//  ContentView.swift
//  Roomi

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthenticationViewModel

    var body: some View {
        NavigationStack {
            if viewModel.authenticationState == .authenticated {
                HomeView()
            } else {
                LoginInView()
            }
        }
        .onAppear {
            viewModel.registerAuthStateHandler()
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AuthenticationViewModel())
}


