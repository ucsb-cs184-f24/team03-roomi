//
//  ContentView.swift
//  Roomi
//
//  Created by Alec Morrison on 10/11/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @EnvironmentObject var relationshipsViewModel: UserRelationshipsViewModel
    
    var body: some View {
        Group {
            if viewModel.userSession != nil {
                HomeView()
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
        .environmentObject(UserRelationshipsViewModel())
}
