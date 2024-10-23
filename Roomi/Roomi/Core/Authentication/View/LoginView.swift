//
//  LoginInView.swift
//  Roomi
//
//  Created by Benjamin Conte on 10/16/24.
//

import SwiftUI

struct LoginView: View {
    @State var email: String = ""
    @State var password: String = ""
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
            NavigationView {
                VStack {
                    Text("Roomi")
                        .fontWeight(.heavy)
                        .font(.largeTitle)
                    
                    TextField("Email", text: $email)
                        .padding()
                        .frame(height: 55)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                        .autocapitalization(.none)
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .frame(height: 55)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                        .autocapitalization(.none)
                    
                    Button("Login") {
                        Task {
                            try await viewModel.login(withEmail: email, password: password)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background(Color.blue)
                    .foregroundStyle(.white)
                    .cornerRadius(10)
                    
                NavigationLink{
                    SignUpView()
                        .navigationBarBackButtonHidden()
                } label: {
                    Text("Sign Up")
                        .foregroundStyle(.blue)
                }
            }
                
            Spacer().frame(height: 20)
        }
        .padding()
    }
}

#Preview {
    LoginView()
        .environmentObject(AuthViewModel())
}
