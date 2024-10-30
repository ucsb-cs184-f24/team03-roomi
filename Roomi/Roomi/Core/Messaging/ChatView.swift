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
    let recipientId: String // Pass this when initializing ChatView
    @State private var messages: [Message] = []
    @State private var newMessageText = ""
    private let db = Firestore.firestore()
    
    var body: some View {
        VStack {
            ScrollView {
                ForEach(messages) { message in
                    Text(message.text)
                        .padding()
                        .background(message.senderId == Auth.auth().currentUser?.uid ? Color.blue.opacity(0.1) : Color.gray.opacity(0.1))
                        .cornerRadius(8)
                        .frame(maxWidth: .infinity, alignment: message.senderId == Auth.auth().currentUser?.uid ? .trailing : .leading)
                }
            }
            .onAppear {
                fetchMessages()
            }
            
            HStack {
                TextField("Type a message", text: $newMessageText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: sendMessage) {
                    Image(systemName: "paperplane.fill")
                        .font(.title2)
                }
                .accessibilityLabel("Send message")
            }
            .padding()
        }
        .navigationTitle("Chat")
    }
    
    private func fetchMessages() {
        guard let currentUser = Auth.auth().currentUser else { return }
        let conversationId = generateConversationId(for: currentUser.uid, and: recipientId)
        
        db.collection("conversations").document(conversationId).collection("messages")
            .order(by: "timestamp", descending: false)
            .addSnapshotListener { snapshot, error in
                guard let documents = snapshot?.documents else { return }
                self.messages = documents.compactMap { doc -> Message? in
                    try? doc.data(as: Message.self)
                }
            }
    }
    
    private func sendMessage() {
        guard let currentUser = Auth.auth().currentUser else { return }
        let conversationId = generateConversationId(for: currentUser.uid, and: recipientId)
        
        let message = Message(text: newMessageText, senderId: currentUser.uid, timestamp: Date(), conversationId: conversationId)
        
        do {
            let conversationRef = db.collection("conversations").document(conversationId)
            try conversationRef.collection("messages").addDocument(from: message)
            
            conversationRef.setData(["participants": [currentUser.uid, recipientId]], merge: true)
            newMessageText = ""
        } catch {
            print("Failed to send message: \(error.localizedDescription)")
        }
    }
}
