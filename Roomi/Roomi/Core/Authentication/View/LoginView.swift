//
//  LoginInView.swift
//  Roomi
//
//  Created by Benjamin Conte on 10/16/24.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @EnvironmentObject var cardsViewModel: CardsViewModel
    
    // could we just init a state for user object here and then edit it accordingly during profile creation
    
    var body: some View {
        NavigationStack {
            
            ZStack{
                LinearGradient(
                    gradient: Gradient(colors: [Color(hex: 0x4A90E2), Color(hex: 0x9013FE)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                VStack {
                    Text("Roomi")
                        .foregroundColor(Color(.white))
                        .fontWeight(.heavy)
                        .font(.largeTitle)
                        .padding(.bottom, 100)
                    Text("Login")
                        .foregroundColor(Color(.white))
                        .fontWeight(.heavy)
                    
                    // display error messages
                    if !viewModel.errorMessage.isEmpty {
                        Text(viewModel.errorMessage)
                            .foregroundColor(Color.red)
                    }
                    
                    // email and password inputs
                    InputView(text: $viewModel.potentialUser.email, title: "Email", placeholder: "Enter Your Email")
                    
                    InputView(text: $viewModel.password, title: "Password", placeholder: "Enter Your Password", isSecureField: true)
                    
                    // login button
                    ButtonView(title: "Login"){
                        // Attempt Login
                        viewModel.loadingState = true
                        Task {
                            try await viewModel.login()
                            cardsViewModel.initialize()
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
                            .foregroundColor(Color(.white))
                        Text("Sign Up")
                            .foregroundColor(Color(.white))
                            .fontWeight(.bold)
                    }
                    
                    Spacer().frame(height:20)
                    
                }
                .padding()
                
                if viewModel.loadingState {
                    Color.black.opacity(0.4)
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack {
                        ProgressView("Logging In...")
                            .progressViewStyle(CircularProgressViewStyle())
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                    }
                }
                
            }
            
        }
    }
}

#Preview {
    LoginView()
        .environmentObject(AuthViewModel())
}
