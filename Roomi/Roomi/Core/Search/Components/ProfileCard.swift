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
                Text(userInformation.name)
                    .font(.title)
                Text(userInformation.gender)
                    .font(.subheadline)
            }
        }
    }
}

#Preview {
    ProfileCard(userInformation: .init(id: .init(), email: "jdoe@gmail.com", name: "John Doe", age: 25, gender: "male", phoneNumber: "+1234567890"))
}
