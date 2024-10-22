//
//  LoginView.swift
//  Roomi
//
//  Created by Alec Morrison on 10/21/24.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Roomi")
                    .fontWeight(.heavy)
                    .font(.largeTitle)
                
                if !viewModel.errorMessage.isEmpty {
                    Text(viewModel.errorMessage)
                        .foregroundColor(Color.red)
                }
                
                TextField("Email", text: $viewModel.email)
                    .padding()
                    .frame(height: 55)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .autocapitalization(.none)
                    .autocorrectionDisabled()
                
                SecureField("Password", text: $viewModel.password)
                    .padding()
                    .frame(height: 55)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .autocapitalization(.none)
                
                Button("Login") {
                    viewModel.login()
                }
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .background(Color.blue)
                .foregroundStyle(.white)
                .cornerRadius(10)
                
                Spacer().frame(height: 20)
                
                NavigationLink("Sign Up", destination: SignUpView())
            }
            .padding()
        }
    }
}

#Preview {
    LoginView()
}

