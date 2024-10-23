//
//  SignUpButtonView.swift
//  Roomi
//
//  Created by Anderson Lee on 10/19/24.
//

import SwiftUI

struct SignUpButtonView: View {
    var body: some View {
        Button("Sign Up") {
            
        }
        .frame(maxWidth: .infinity)
        .frame(height: 55)
        .background(Color.blue)
        .foregroundStyle(.white)
        .cornerRadius(10)    }
}

#Preview {
    SignUpButtonView()
}
