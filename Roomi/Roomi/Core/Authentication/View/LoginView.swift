//
//  LoginInView.swift
//  Roomi
//
//  Created by Benjamin Conte on 10/16/24.
//

import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @EnvironmentObject var viewModel: AuthViewModel
    
    // could we just init a state for user object here and then edit it accordingly during profile creation
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Roomi")
                    .fontWeight(.heavy)
                    .font(.largeTitle)
                
                InputView(text: $email, title: "Email", placeholder: "Enter Your Email")
                
                InputView(text: $password, title: "Password", placeholder: "Enter Your password", isSecureField: true)
                
                ButtonView(title: "Login", background: .blue){
                    // Attempt Login
                    Task {
                        try await viewModel.login(withEmail: email, password: password)
                    }
                }
                .frame(height: 50)
                .padding()
                
//                ButtonView(title: "Sign In", email: email, password: password)
                                
                NavigationLink {
                    SignUpView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    HStack(spacing: 3) {
                        Text("Don't have an account?")
                        Text("Sign Up").fontWeight(.bold)
                    }
                    .font(.system(size: 14))
                }
                
                Spacer().frame(height:20)
                
            }
            .padding()
            
        }
    }
}

#Preview {
    LoginView()
}
