//
//  SignUpView.swift
//  Roomi
//
//  Created by Benjamin Conte on 10/17/24.
//

import SwiftUI

struct SignUpView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @Environment(\.dismiss) var dismiss
    var body: some View {
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
            
            SecureField("Confirm Password", text: $confirmPassword)
                .padding()
                .frame(height: 55)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .autocapitalization(.none)
            
            
            Button {
                
            } label: {
                HStack {
                    Text("Sign Up")
                    Image(systemName: "arrow.right")
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .background(Color.blue)
            .foregroundStyle(.white)
            .cornerRadius(10)
            .padding(.top, 12)
        }
        .padding()
        
        Button {
            dismiss()
        } label: {
            Text("Already have an Account?")
            Text("Sign In")
                .bold()
        }
    }
}

#Preview {
    SignUpView()
}
