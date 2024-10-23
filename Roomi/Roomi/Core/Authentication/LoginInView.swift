//
//  LoginInView.swift
//  Roomi
//
//  Created by Benjamin Conte on 10/16/24.
//

import SwiftUI

struct LoginInView: View {
    @State var email: String = ""
    @State var password: String = ""
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
            
            Button("Login") {
                
            }
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .background(Color.blue)
            .foregroundStyle(.white)
            .cornerRadius(10)
            
            Spacer().frame(height: 20)
            
            Button("Sign Up") {
                
            }
        }
        .padding()
    }
}

#Preview {
    LoginInView()
}
