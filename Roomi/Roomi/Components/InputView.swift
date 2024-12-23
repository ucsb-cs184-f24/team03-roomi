//
//  InputView.swift
//  Roomi
//
//  Created by Anderson Lee on 10/19/24.
//

import SwiftUI

struct InputView: View {
    @Binding var text: String
    let title: String
    let placeholder: String
    var isSecureField = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .foregroundColor(Color(.white))
                .fontWeight(.semibold)
                .font(.footnote)
            
            if isSecureField {
                SecureField(placeholder, text: $text)
                    .padding()
                    .frame(height: 55)
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(10)
                    .autocapitalization(.none)
            }
            else {
                TextField(placeholder, text: $text)
                    .padding()
                    .frame(height: 55)
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(10)
                    .autocapitalization(.none)
            }
        }
    }
}

#Preview {
    InputView(text: .constant(""), title: "", placeholder: "")
}
