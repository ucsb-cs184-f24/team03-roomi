//
//  SignUpView.swift
//  Roomi
//
//  Created by Alec Morrison on 10/21/24.
//

import SwiftUI

struct SignUpView: View {
    @StateObject var viewModel = SignUpViewViewModel()
    
    var body: some View {
        VStack {
            Text("Roomi")
                .fontWeight(.heavy)
                .font(.largeTitle)
            
            TextField("Full Name", text: $viewModel.name)
                .padding()
                .frame(height: 55)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .autocorrectionDisabled()
            
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
            
            Button("Sign Up") {
                viewModel.register()
                // attempt registration
            }
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .background(Color.blue)
            .foregroundStyle(.white)
            .cornerRadius(10)
            
            Spacer().frame(height: 20)
        }
        .padding()
    }
}

#Preview {
    SignUpView()
}
