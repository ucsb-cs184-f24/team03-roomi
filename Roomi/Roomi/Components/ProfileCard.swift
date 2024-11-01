//
//  ProfileCard.swift
//  Roomi
//
//  Created by Benjamin Conte on 10/26/24.
//

import SwiftUI

struct ProfileCard: View {
    let userInformation: User
    var body: some View {
        NavigationLink (destination: ExpandedProfileCard(userInformation: userInformation)) {
            VStack(alignment: .leading) {
                ZStack {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 80)
                        .clipShape(Circle())
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                }
            }
            VStack {
                    Text(userInformation.name)
                        .font(.title)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                    Text(userInformation.gender)
                        .font(.subheadline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                Text("\(userInformation.age) years old")
                    .font(.subheadline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
            }
        }
    }
}

#Preview {
    ProfileCard(userInformation: .init(id: .init(), email: "jdoe@gmail.com", name: "John Doe", age: 25, gender: "male", phoneNumber: "+1234567890", likes: [], dislikes: [], matches: []))
        
        
}
