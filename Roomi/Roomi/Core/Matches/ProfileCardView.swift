//
//  ProfileCardView.swift
//  Roomi
//
//  Created by Khang Chung on 10/31/24.
//

import SwiftUI

struct ProfileCardView: View {
    let userInformation: User

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white.opacity(0.15))
                .frame(height: 200)
                .overlay(
                    VStack {
                        Text(userInformation.name)
                            .font(.title2).bold()
                            .foregroundColor(.white)
                        
                        Text("\(userInformation.age) years old")
                            .foregroundColor(.white.opacity(0.7))
                            .padding(.bottom, 10)
                    }
                )
                .shadow(radius: 10)
                .padding(.horizontal)
        }
    }
}

struct ProfileImageView: View {
    let image: String
    var size: CGFloat = 80

    var body: some View {
        Image(systemName: image)
            .resizable()
            .scaledToFit()
            .frame(width: size, height: size)
            .padding()
            .background(Color.white.opacity(0.15))
            .clipShape(Circle())
            .shadow(radius: 10)
    }
}
