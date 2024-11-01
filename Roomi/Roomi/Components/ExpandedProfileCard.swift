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
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Image("Sample_Profile_Image")
                .resizable()
                .frame(width: 300, height: 400)

            Text("Sex: \(userInformation.gender)")
                .font(.subheadline)
            Text("\(userInformation.age) years old")
                .font(.subheadline)
        }
        .padding(.top)
        .frame(maxHeight: .infinity, alignment: .top)
        
        HStack {
            Button {
                
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.red)
            }

            Button {
                
            } label: {
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.green)
            }
        }.padding(.bottom)
    }
}

#Preview {
    ExpandedProfileCard(userInformation: .init(id: .init(), email: "jdoe@gmail.com", name: "John Doe", age: 25, gender: "male", phoneNumber: "+1234567890"))
}
