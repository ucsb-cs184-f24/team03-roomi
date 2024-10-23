//
//  SignUpView.swift
//  Roomi
//
//  Created by Anderson Lee on 10/18/24.
//

import SwiftUI

struct SignUpView: View {
    @State private var email: String = ""
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var password: String = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack {
            Text("Roomi")
                .fontWeight(.heavy)
                .font(.largeTitle)
            
            InputView(text: $email, title: "Email", placeholder: "Enter Your Email")
                .autocapitalization(.none)
            
            InputView(text: $password, title: "Password", placeholder: "Enter Your Password", isSecureField: true)
                .autocapitalization(.none)
            
            ButtonView(title: "Sign Up")
            
            Button {
                dismiss()
            } label: {
                HStack(spacing: 3) {
                    Text("Already have an account?")
                    Text("Login").fontWeight(.bold)
                }
                .font(.system(size: 14))
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
