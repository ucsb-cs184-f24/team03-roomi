//
//  SearchViewModel.swift
//  Roomi
//
//  Created by Benjamin Conte on 11/13/24.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

@MainActor
class SearchViewModel: ObservableObject {
    @Published var userList = [User]()
    @Published var potentialUsers = [User]()
    @Published var likedList = [User]()
    @Published var matchList = [User]()
    @Published var dislikedList = [User]()
    @Published var currentUser: User?
    
    private let db = Firestore.firestore()
    
    init() {
        print("SearchViewModel init")
        Task {
            await fetchCurrentUser()
            await getAllUsers()
            await getAllLikes()
            await getAllDislikes()
            await getAllMatches()
            getAllPotentialUsers()
        }
    }
    
    func initialize() async {
        Task {
            await fetchCurrentUser()
            await getAllUsers()
            await getAllLikes()
            await getAllDislikes()
            await getAllMatches()
            getAllPotentialUsers()
        }
    }
    
    func fetchCurrentUser() async {
        do {
            guard let uid = Auth.auth().currentUser?.uid else { return }
            let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
            self.currentUser = try snapshot.data(as: User.self)
        }
        catch {
            print("Could not fetch user with error \(error.localizedDescription)")
        }
    }
    
    
    func getAllUsers() async {
        do {
            // Read in documents
            let snapshot = try await db.collection("users").getDocuments()
            
            // Check if no documents
            let documents = snapshot.documents
            
            // Extract profiles
            self.userList = documents.compactMap { user in
                // Only show other users
                if user.documentID == self.currentUser?.id {
                    return nil
                }
                
                // Return the User object if it passes all filters
                return User(
                    id: user.documentID,
                    email: user.get("email") as? String ?? "",
                    name: user.get("name") as? String ?? "",
                    age: user.get("age") as? Int ?? 0,
                    gender: user.get("gender") as? String ?? "",
                    phoneNumber: user.get("phoneNumber") as? String ?? ""
                )
            }
        } catch {
            print("Error fetching users: \(error)")
        }
    }
    
    // Users the current user has not liked, matched, or disliked
    func getAllPotentialUsers() {
        // Check if current user is nil
        guard let currentUser = self.currentUser else {
            return
        }
        
        // Filter out users that are liked, matched, or disliked
        self.potentialUsers = self.userList.filter { user in
            !self.likedList.contains(where: { $0.id == user.id }) &&
            !self.matchList.contains(where: { $0.id == user.id }) &&
            !self.dislikedList.contains(where: { $0.id == user.id }) && user.id != currentUser.id
        }
        
    }
    
    func like(otherUser: User) async {
        // Check if current user is nil
        guard let currentUser = self.currentUser else {
            return
        }
        
        let currentUserRef = db.collection("users").document(currentUser.id)
        let otherUserRef = db.collection("users").document(otherUser.id)
        
        do {
            let otherUserLikedList = try await otherUserRef.getDocument().data()?["liked"] as? [String] ?? []
            
            if(otherUserLikedList.contains(currentUser.id)) { // Match
                try await otherUserRef.updateData(["liked": FieldValue.arrayRemove([currentUser.id])])
                try await currentUserRef.updateData(["matched": FieldValue.arrayUnion([otherUser.id])])
                try await otherUserRef.updateData(["matched": FieldValue.arrayUnion([currentUser.id])])
                self.matchList.append(otherUser)
            } else {
                try await currentUserRef.updateData(["liked": FieldValue.arrayUnion([otherUser.id])])
                self.likedList.append(otherUser)
            }
            
            self.potentialUsers.removeAll { $0.id == otherUser.id }
        } catch {
            print("Error adding liked user: \(error)")
        }
    }
    
    func dislike(otherUser: User) async {
        guard let currentUser = self.currentUser else {
            return
        }
        
        let currentUserRef = db.collection("users").document(currentUser.id)
        do {
            try await currentUserRef.updateData(["disliked": FieldValue.arrayUnion([otherUser.id as String])])
            self.dislikedList.append(otherUser)
            self.potentialUsers.removeAll { $0.id == otherUser.id }
        } catch {
            print("Error adding disliked user: \(error)")
        }
        
    }
    
    func getAllLikes() async {
        // Check if current user is nil
        guard let currentUser = self.currentUser else {
            return
        }
        
        let currentUserRef = db.collection("users").document(currentUser.id)
        
        do {
            let snapshot = try await currentUserRef.getDocument()
            let likedList = snapshot.get("liked") as? [String] ?? []
            
            self.likedList = self.userList.filter { user in
                likedList.contains(user.id)
            }
        } catch {
            print("Error fetching liked users: \(error)")
        }
    }
    
    func getAllMatches() async {
        // Check if current user is nil
        guard let currentUser = self.currentUser else {
            return
        }
        
        let currentUserRef = db.collection("users").document(currentUser.id)
        
        do {
            let snapshot = try await currentUserRef.getDocument()
            let matchedList = snapshot.get("matched") as? [String] ?? []
            
            self.matchList = self.userList.filter { user in
                matchedList.contains(user.id)
            }
        } catch {
            print("Error fetching matched users: \(error)")
        }
    }
    
    func getAllDislikes() async {
        // Check if current user is nil
        guard let currentUser = self.currentUser else {
            return
        }
        
        let currentUserRef = db.collection("users").document(currentUser.id)
        
        do {
            let snapshot = try await currentUserRef.getDocument()
            let dislikedList = snapshot.get("disliked") as? [String] ?? []
            
            self.dislikedList = self.userList.filter { user in
                dislikedList.contains(user.id)
            }
        } catch {
            print("Error fetching disliked users: \(error)")
        }
    }
}
