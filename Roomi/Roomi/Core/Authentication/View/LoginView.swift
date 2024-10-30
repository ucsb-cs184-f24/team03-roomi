//
//  LoginInView.swift
//  Roomi
//
//  Created by Benjamin Conte on 10/16/24.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    // could we just init a state for user object here and then edit it accordingly during profile creation
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Roomi")
                    .fontWeight(.heavy)
                    .font(.largeTitle)
                
                // display error messages
//                if !viewModel.errorMessage.isEmpty {
//                    Text(viewModel.errorMessage)
//                        .foregroundColor(Color.red)
//                }
                
                // email and password inputs
                InputView(text: $viewModel.potentialUser.email, title: "Email", placeholder: "Enter Your Email")
                
                InputView(text: $viewModel.password, title: "Password", placeholder: "Enter Your Password", isSecureField: true)
                
                // login button
                ButtonView(title: "Login", background: .blue){
                    // Attempt Login
                    Task {
                        try await viewModel.login()
                    }
                }
                .frame(height: 50)
                .padding()
                
                              
                // button to switch to sign up view
                Button (action: {
                    viewModel.loginState.toggle()
                    viewModel.errorMessage = ""
                }) {
                        Text("Don't have an account?")
                        Text("Sign Up")
                        .fontWeight(.bold)
                    }
                
                Spacer().frame(height:20)
                
            }
            .padding()
            
        }
    }
}

#Preview {
    LoginView()
        .environmentObject(AuthViewModel())
}
