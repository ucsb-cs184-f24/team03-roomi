//
//  UserRelationshipsViewModel.swift
//  Roomi
//
//  Created by Anderson Lee on 11/1/24.
//

import Foundation
import FirebaseFirestore

@MainActor
class UserRelationshipsViewModel: ObservableObject {
    @Published var likes = Set<String>()
    @Published var dislikes = Set<String>()
    @Published var matches = [String]()
    
    init() {}
    
    func fetchLikes(userObj: User) async throws {
    }
    
    func addLike(userId: String) {
        likes.insert(userId)
    }
    
    func addDislike(userId: String) {
        dislikes.insert(userId)
    }
}
