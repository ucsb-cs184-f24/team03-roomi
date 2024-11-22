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
    let recipientName: String

    var body: some View {
        VStack {
            ScrollViewReader { proxy in
                ScrollView {
                    ForEach(viewModel.messages) { message in
                        VStack(alignment: message.senderId == Auth.auth().currentUser?.uid ? .trailing : .leading, spacing: 4) {
                            Text(message.text)
                                .foregroundColor(.white)
                                .padding()
                                .background(message.senderId == Auth.auth().currentUser?.uid ? Color.cyan.opacity(0.8) : Color.black.opacity(0.3))
                                .cornerRadius(8)
                                .frame(maxWidth: .infinity, alignment: message.senderId == Auth.auth().currentUser?.uid ? .trailing : .leading)
                                .id(message.id)
                            
                            Text(formattedTimestamp(for: message.timestamp))
                                .font(.caption2)
                                .foregroundColor(.white)
                        }
                        .padding(message.senderId == Auth.auth().currentUser?.uid ? .leading : .trailing, 50)
                    }
                }
                .onChange(of: viewModel.messages.count) {
                    if let lastMessage = viewModel.messages.last {
                        withAnimation {
                            proxy.scrollTo(lastMessage.id, anchor: .bottom)
                        }
                    }
                }
                .onAppear {
                    if let lastMessage = viewModel.messages.last {
                        proxy.scrollTo(lastMessage.id, anchor: .bottom)
                    }
                }
            }
            
            HStack {
                TextField("Type a message", text: $viewModel.newMessageText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: viewModel.sendMessage) {
                    Image(systemName: "paperplane.fill")
                        .font(.title2)
                        .foregroundColor(Color.cyan)
                }
                .accessibilityLabel("Send message")
            }
            .padding()
        }
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color(hex: 0x4A90E2), Color(hex: 0x9013FE)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)
        )
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(recipientName)
                    .font(.headline)
                    .foregroundColor(.black)
            }
        }
    }

    private func formattedTimestamp(for date: Date) -> String {
        let calendar = Calendar.current

        if calendar.isDateInToday(date) {
            return DateFormatter.messageTimestampFormatter.string(from: date)
        } else {
            return "\(DateFormatter.messageDateFormatter.string(from: date)) at \(DateFormatter.messageTimestampFormatter.string(from: date))"
        }
    }
}
