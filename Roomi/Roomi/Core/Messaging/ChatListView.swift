//
//  ChatListView.swift
//  Roomi
//
//  Created by Braden Castillo on 10/30/24.
//

import SwiftUI

struct ChatListView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @EnvironmentObject var searchViewModel: SearchViewModel

    var body: some View {
        List(searchViewModel.userList.filter { $0.id != viewModel.userSession?.uid }) { user in
            NavigationLink(destination: ChatView(viewModel: MessagingViewModel(recipientId: user.id))) {
                Text("Chat with \(user.name)")
            }
        }
        .onAppear {
            Task {
                await searchViewModel.getAllUsers()
            }
        }
        .navigationTitle("Messages")
    }
}


#Preview {
    ChatListView()
        .environmentObject(AuthViewModel())
        .environmentObject(SearchViewModel())
}
