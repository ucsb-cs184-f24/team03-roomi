//
//  ChatListView.swift
//  Roomi
//
//  Created by Braden Castillo on 10/30/24.
//

import SwiftUI

struct ChatListView: View {
    @EnvironmentObject var cardsViewModel: CardsViewModel
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        List(cardsViewModel.matchList.filter { $0.id != viewModel.userSession?.uid }) { user in
            NavigationLink(
                destination: ChatView(
                    viewModel: MessagingViewModel(recipientId: user.id),
                    recipientName: user.name
                )
            ) {
                Text("Chat with \(user.name)")
            }
        }
        .onAppear {
            Task {
                try await cardsViewModel.getAllMatches()
            }
        }
        .navigationTitle("Messages")
    }
}
