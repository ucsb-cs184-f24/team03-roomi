//
//  ExpandedProfile.swift
//  Roomi
//
//  Created by Benjamin Conte on 10/26/24.
//

import SwiftUI

struct ExpandedProfileCard: View {
    let userInformation: User
    @EnvironmentObject var userRelationshipsViewModel: UserRelationshipsViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(userInformation.name)
                .font(.system(size: 40, weight: .bold))
            
            // replace with user image(s) once implemented
            Image("Sample_Profile_Image")
                .resizable()
                .frame(width: 300, height: 400)

            Text("Sex: \(userInformation.gender.capitalized)")
                .font(.system(size: 20))
            Text("Age: \(userInformation.age) years old")
                .font(.system(size: 20))
        }
        .padding(.top)
        .frame(maxHeight: .infinity, alignment: .top)
        
        HStack {
            Button {
                Task {
                    userRelationshipsViewModel.addDislike(userId: userInformation.id)
                }
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.red)
            }

            Button {
                Task {
                    userRelationshipsViewModel.addLike(userId: userInformation.id)
                    print(userRelationshipsViewModel.likes)
                }
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
    ExpandedProfileCard(userInformation: .init(id: .init(), email: "jdoe@gmail.com", name: "John Doe", age: 25, gender: "male", phoneNumber: "+1234567890", likes: [], dislikes: [], matches: []))
        .environmentObject(UserRelationshipsViewModel())
}
