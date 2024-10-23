//
//  LoginInView.swift
//  Roomi
//
//  Created by Benjamin Conte on 10/16/24.
//

import SwiftUI

struct LoginInView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    var body: some View {
        NavigationStack {
            VStack {
                Text("Roomi")
                    .fontWeight(.heavy)
                    .font(.largeTitle)
                
                InputView(text: $email, title: "Email", placeholder: "Enter Your Email")
                
                InputView(text: $password, title: "Password", placeholder: "Enter Your password")
                
                ButtonView(title: "Sign In")
                                
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
    LoginInView()
}
