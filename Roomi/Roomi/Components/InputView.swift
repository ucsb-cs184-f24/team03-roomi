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
                .foregroundColor(Color(.darkGray))
                .fontWeight(.semibold)
                .font(.footnote)
            
            if isSecureField {
                SecureField(placeholder, text: $text)
                    .padding()
                    .frame(height: 55)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
            }
            else {
                TextField(placeholder, text: $text)
                    .padding()
                    .frame(height: 55)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
            }
        }
    }
}

#Preview {
    InputView(text: .constant(""), title: "", placeholder: "")
}
