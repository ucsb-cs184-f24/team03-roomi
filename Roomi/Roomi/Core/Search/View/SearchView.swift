//
//  SearchView.swift
//  Roomi
//
//  Created by Benjamin Conte on 10/26/24.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var relationshipsViewModel: UserRelationshipsViewModel
    
    var body: some View {
        NavigationView {
            List (relationshipsViewModel.userList) { user in
                ProfileCard(userInformation: user)
            }
            .onAppear { // Gets all users when the view is opened
                Task {
                    await relationshipsViewModel.getAllUsers()
                    print(relationshipsViewModel.userList)
                    relationshipsViewModel.userList = relationshipsViewModel.userList.filter({ user in !relationshipsViewModel.likes.contains(user.id) && !relationshipsViewModel.dislikes.contains(user.id)})
                }
            }
        }
    }
}

#Preview {
    SearchView()
        .environmentObject(AuthViewModel())
        .environmentObject(UserRelationshipsViewModel())
}
