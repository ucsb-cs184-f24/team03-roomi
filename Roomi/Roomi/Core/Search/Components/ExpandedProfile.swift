//
//  ExpandedProfile.swift
//  Roomi
//
//  Created by Benjamin Conte on 10/26/24.
//

import SwiftUI

struct ExpandedProfile: View {
    let profileInformation: Profile
    var body: some View {
        VStack(alignment: .leading) {
            Text(profileInformation.fullname)
                .font(.title)
            Text(profileInformation.location)
                .font(.subheadline)
            Text(profileInformation.hobby)
                .font(.subheadline)
            Text("\(profileInformation.age) years old")
                .font(.subheadline)
        }
        .padding(.top)
        
        HStack {
            Button {
                
            } label: {
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.green)
            }
            
            Button {
                
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.red)
            }
        }.padding(.bottom)
    }
}

#Preview {
    ExpandedProfile(profileInformation: .init(id: .init(), fullname: "Michael Jordan", location: "San Diego", hobby: "Basketball", age: 34))
}
