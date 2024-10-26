//
//  ProfileCard.swift
//  Roomi
//
//  Created by Benjamin Conte on 10/26/24.
//

import SwiftUI

struct ProfileCard: View {
    let profileInformation: Profile
    var body: some View {
        NavigationLink (destination: ExpandedProfile(profileInformation: profileInformation)) {
            VStack(alignment: .leading) {
                Text(profileInformation.fullname)
                    .font(.title)
                Text(profileInformation.location)
                    .font(.subheadline)
            }
        }
    }
}

#Preview {
    ProfileCard(profileInformation: .init(id: .init(), fullname: "Michael Jordan", location: "San Diego", hobby: "Basketball", age: 34))
}
