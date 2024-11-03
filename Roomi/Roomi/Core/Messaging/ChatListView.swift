//
//  ChatListView.swift
//  Roomi
//
//  Created by Braden Castillo on 10/30/24.
//

import SwiftUI

struct ChatListView: View {
    @EnvironmentObject var viewModel: AuthViewModel

    var body: some View {
        List(viewModel.userList.filter { $0.id != viewModel.userSession?.uid }) { user in
            NavigationLink(destination: ChatView(viewModel: MessagingViewModel(recipientId: user.id))) {
                Text("Chat with \(user.name)")
            }
        }
        .onAppear {
            viewModel.getAllUsers()
        }
    }
}
