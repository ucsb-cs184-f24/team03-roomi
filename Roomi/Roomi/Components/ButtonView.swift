//
//  SignUpButtonView.swift
//  Roomi
//
//  Created by Anderson Lee on 10/19/24.
//

import SwiftUI

struct ButtonView: View {
    let title: String
    var body: some View {
        Button(title) {}
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .background(Color.blue)
            .foregroundStyle(.white)
            .cornerRadius(10)
    }
}

#Preview {
    ButtonView(title: "")
}
