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
    @Published var userList = [User]()
    
    init() {}
    
    func fetchLikes(userObj: User) async throws {
    }
    
    func addLike(userId: String) {
        likes.insert(userId)
    }
    
    func addDislike(userId: String) {
        dislikes.insert(userId)
    }
    
    func getAllUsers() async {
        do {
            // Get reference to Database
            let db = Firestore.firestore()
            
            let snapshot = try await db.collection("users").getDocuments()
            
            self.userList =  snapshot.documents.map { user in
                                return User(id: user.documentID, email: user.get("email") as? String ?? "", name: user.get("name") as? String ?? "", age: user.get("age") as? Int ?? 0, gender: user.get("gender") as? String ?? "", phoneNumber: user.get("phoneNumber") as? String ?? "", likes: [], dislikes: [], matches: [])
                            }
        }
        catch {
            print("DEBUG: Problem fetching all users with error: \(error.localizedDescription)")
        }
    }
}
