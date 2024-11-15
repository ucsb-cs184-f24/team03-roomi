//
//  ExpandedProfile.swift
//  Roomi
//
//  Created by Benjamin Conte on 10/26/24.
//

import SwiftUI

struct ExpandedProfileCard: View {
    let userInformation: User
    var body: some View {
        VStack(alignment: .leading) {
            Text(userInformation.name)
                .font(.title)
            Text(userInformation.gender)
                .font(.subheadline)
            Text("\(userInformation.age) years old")
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
    ExpandedProfileCard(userInformation: .init(id: .init(), email: "jdoe@gmail.com", name: "John Doe", age: 25, gender: "male", phoneNumber: "+1234567890"))
}
