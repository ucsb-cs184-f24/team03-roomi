//
//  MessagingViewModel.swift
//  Roomi
//
//  Created by Braden Castillo on 11/3/24.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseAuth

class MessagingViewModel: ObservableObject {
    @Published var messages: [Message] = []
    @Published var newMessageText = ""
    private let db = Firestore.firestore()
    
    var recipientId: String
    private var listenerRegistration: ListenerRegistration?
    
    init(recipientId: String) {
        self.recipientId = recipientId
        fetchMessages()
    }
    
    deinit {
        listenerRegistration?.remove()
    }
    
    func fetchMessages() {
        guard let currentUser = Auth.auth().currentUser else { return }
        let conversationId = generateConversationId(for: currentUser.uid, and: recipientId)
        
        listenerRegistration = db.collection("conversations").document(conversationId).collection("messages")
            .order(by: "timestamp", descending: false)
            .addSnapshotListener { snapshot, error in
                guard let documents = snapshot?.documents else { return }
                self.messages = documents.compactMap { doc -> Message? in
                    try? doc.data(as: Message.self)
                }
            }
    }
    
    func sendMessage() {
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
