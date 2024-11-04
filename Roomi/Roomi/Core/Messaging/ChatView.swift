//
//  ChatView.swift
//  Roomi
//
//  Created by Braden Castillo on 10/30/24.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseAuth

struct ChatView: View {
    @ObservedObject var viewModel: MessagingViewModel

    var body: some View {
        VStack {
            ScrollView {
                ForEach(viewModel.messages) { message in
                    Text(message.text)
                        .padding()
                        .background(message.senderId == Auth.auth().currentUser?.uid ? Color.blue.opacity(0.1) : Color.gray.opacity(0.1))
                        .cornerRadius(8)
                        .frame(maxWidth: .infinity, alignment: message.senderId == Auth.auth().currentUser?.uid ? .trailing : .leading)
                }
            }

            HStack {
                TextField("Type a message", text: $viewModel.newMessageText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: viewModel.sendMessage) {
                    Image(systemName: "paperplane.fill")
                        .font(.title2)
                }
                .accessibilityLabel("Send message")
            }
            .padding()
        }
        .navigationTitle("Chat")
    }
}
