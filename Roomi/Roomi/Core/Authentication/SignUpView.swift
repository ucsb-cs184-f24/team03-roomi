//
//  SignUpView.swift
//  Roomi
//
//  Created by Anderson Lee on 10/18/24.
//

import SwiftUI

struct SignUpView: View {
    @State private var email: String = ""
    @State private var fullName: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Text("Roomi")
                .fontWeight(.heavy)
                .font(.largeTitle)
            
            InputView(text: $email, title: "Email", placeholder: "Enter Your Email")
            
            InputView(text: $fullName, title: "Full Name", placeholder: "Enter Your Full Name")
            
            InputView(text: $password, title: "Password", placeholder: "Enter Your Password", isSecureField: true)
            
            InputView(text: $confirmPassword, title: "Confirm Password", placeholder: "Confirm Your Password", isSecureField: true)
            
            SignUpButtonView()
            
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
}
