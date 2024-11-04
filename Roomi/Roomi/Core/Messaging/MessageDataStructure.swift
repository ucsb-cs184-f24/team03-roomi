//
//  MessageDataStructure.swift
//  Roomi
//
//  Created by Braden Castillo on 10/30/24.
//

import Foundation
import FirebaseFirestore

struct Message: Identifiable, Codable {
    @DocumentID var id: String?
    var text: String
    var senderId: String
    var timestamp: Date
    var conversationId: String?
}

func generateConversationId(for user1: String, and user2: String) -> String {
    let ids = [user1, user2].sorted()
    return ids.joined(separator: "_")
}
