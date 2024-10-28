//
//  SignUpView.swift
//  Roomi
//
//  Created by Anderson Lee on 10/18/24.
//

import SwiftUI

struct SignUpView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack {
            Text("Roomi")
                .fontWeight(.heavy)
                .font(.largeTitle)
            
            InputView(text: $email, title: "Email", placeholder: "Enter Your Email")
            
            InputView(text: $password, title: "Password", placeholder: "Enter Your Password", isSecureField: true)
            
            NavigationLink(destination: ProfileCreationView()) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.blue)
                        .frame(height: 50)
                    
                    Text("Sign Up")
                        .foregroundColor(Color.white)
                        .bold()
                }
            }
            .padding()
            
            Button (action: {
                viewModel.loginState.toggle()
            }) {
                    Text("Already have an account?")
                    Text("Login")
                    .fontWeight(.bold)
                }
            
            Spacer().frame(height:20)
        }
        .padding()
    }
}

#Preview {
    SignUpView()
        .environmentObject(AuthViewModel())
}
