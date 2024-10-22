//
//  AboutView.swift
//  Roomi
//
//  Created by Braden Castillo on 10/21/24.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
            Text("Roomi is a mobile app that allows you to find and connect with potential roommates that most closely align with your personal preferences/interests. Thanks for using Roomi! :)")
                .font(.title)
                .padding()
                .navigationTitle("About Roomi")
        }
}

#Preview {
    AboutView()
}
