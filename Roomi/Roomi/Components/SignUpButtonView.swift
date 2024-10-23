//
//  SignUpButtonView.swift
//  Roomi
//
//  Created by Anderson Lee on 10/19/24.
//

import SwiftUI

struct SignUpButtonView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    var email: String
    var password: String
    
    var body: some View {
        Button("Sign Up") {
            Task {
                try await viewModel.signUp(withEmail: email, password: password)
                
                if viewModel.userSession != nil {
                    print("Jumping to home screen...")
                }
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 55)
        .background(Color.blue)
        .foregroundStyle(.white)
        .cornerRadius(10)
    }
}

#Preview {
    SignUpButtonView(email: "", password: "")
        .environmentObject(AuthViewModel())
}
