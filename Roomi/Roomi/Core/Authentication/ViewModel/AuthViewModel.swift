//
//  AuthViewModel.swift
//  Roomi
//
//  Created by Anderson Lee on 10/21/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

@MainActor
class AuthViewModel: ObservableObject {
    @Published var loginState = true
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    @Published var potentialUser = User(id: "", email: "", name: "", age: 0, gender: "male", phoneNumber: "")
    @Published var password = ""
    @Published var errorMessage = ""
    @Published var userList = [User]()
    @Published var likedList = [User]()
    @Published var matchList = [User]()
    @Published var dislikeList = [User]()
    
    private let db = Firestore.firestore()
    
    init() {
        self.userSession = Auth.auth().currentUser
        Task {
            await fetchUser()
        }
    }
    
    func login() async throws {
        guard validate() else {
            return
        }
        
        do {
            let result = try await Auth.auth().signIn(withEmail: potentialUser.email, password: self.password)
            self.userSession = result.user
            await fetchUser()
        }
        catch {
            errorMessage = "Error Logging In"
            print("DEBUG: Failed logging in with error: \(error.localizedDescription)")
        }
    }
    
    func signUp() async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: potentialUser.email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid,
                            email: potentialUser.email,
                            name: potentialUser.name,
                            age: potentialUser.age,
                            gender: potentialUser.gender,
                            phoneNumber: potentialUser.phoneNumber)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            await fetchUser()
        }
        catch {
            errorMessage = "Error Signing Up"
            print("DEBUG: Failed to create user with error: \(error.localizedDescription)")
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
            self.potentialUser = User(id: "", email: "", name: "", age: 0, gender: "male", phoneNumber: "")
            self.password = ""
            self.loginState = true
            
        }
        catch {
            print("DEBUG: Failed to sign out with error: \(error.localizedDescription)")
        }
    }
    
    func deleteAccount() {
        
    }
    
    func fetchUser() async {
        do {
            guard let uid = Auth.auth().currentUser?.uid else { return }
            let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
            self.currentUser = try snapshot.data(as: User.self)
        }
        catch {
            print("Could not fetch user with error \(error.localizedDescription)")
        }
    }
    
    func validate() -> Bool {
        // Reset Error Message
        errorMessage = ""
        
        //Check for empty Fields
        guard !potentialUser.email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            
            errorMessage = "Please Fill in All Fields"
            return false
        }
        
        // Check Valid Email
        guard potentialUser.email.contains("@") && potentialUser.email.contains(".") else {
            errorMessage = "Please Enter Valid Email"
            return false
        }
        return true
    }
    
    func getAllUsers() {
        // Read in documents
        db.collection("users").getDocuments { snapshot, error in
            // Check if no documents
            guard let documents = snapshot?.documents else {
                return
            }
            
            // Extract profiles
            self.userList =  documents.compactMap { user in
                if(user.documentID == self.currentUser?.id) { // Only show other users
                    return nil
                }
                
                if(self.likedList.contains { likedUser in
                    likedUser.id == user.documentID
                }) {
                    return nil
                }
                
                if(self.matchList.contains { matchUser in
                    matchUser.id == user.documentID
                }) {
                    return nil
                }
                
                if(self.dislikeList.contains { dislikedUser in
                    dislikedUser.id == user.documentID
                }) {
                    return nil
                }
                
                return User(id: user.documentID, email: user.get("email") as? String ?? "", name: user.get("name") as? String ?? "", age: user.get("age") as? Int ?? 0, gender: user.get("gender") as? String ?? "", phoneNumber: user.get("phoneNumber") as? String ?? "")
            }
        }
    }
    
    func getAllMatches() {
        // Check if current user is nil
        guard let currentUser = self.currentUser else {
            return
        }
        
        // Look at current user's document
        db.collection("users").document(currentUser.id).getDocument { snapshot, error in
            // Check if document exists
            guard let documents = snapshot else {
                return
            }
            
            // Populate list of User matches based on user IDs in current users document
            let matchIds = documents.get("matches") as? [String] ?? [String]()
            
            // Filter out matched users from userList
            self.matchList = matchIds.compactMap { id in
                self.userList.first { user in
                    user.id == id
                }
            }
        }
    }
    
    func getAllLikes() {
        // Check if current user is nil
        guard let currentUser = self.currentUser else {
            return
        }
        
        // Look at current user's document
        db.collection("users").document(currentUser.id).getDocument { snapshot, error in
            // Check if document exists
            guard let documents = snapshot else {
                return
            }
            
            // Populate list of user likes based on user IDs in current users liked document
            let likedIds = documents.get("liked") as? [String] ?? [String]()
            
            // Filter out liked users from userList
            self.likedList = likedIds.compactMap { id in
                self.userList.first { user in
                    user.id == id
                }
            }
        }
    }
    
    func getAllDislikes() {
        // Check if current user is nil
        guard let currentUser = self.currentUser else {
            return
        }
        
        // Look at current user's document
        db.collection("users").document(currentUser.id).getDocument { snapshot, error in
            // Check if document exists
            guard let documents = snapshot else {
                return
            }
            
            // Populate list of user dislikes based on user IDs in current users disliked document
            let dislikedIds = documents.get("disliked") as? [String] ?? [String]()
            
            // Filter out disliked users from userList
            self.dislikeList = dislikedIds.compactMap { id in
                self.userList.first { user in
                    user.id == id
                }
            }
        }
    }
    
    func like(user: User) {
        guard let currentUser = self.currentUser else {
            return
        }
        
        // Look at likees document
        db.collection("users").document(user.id).getDocument { snapshot, error in
            // Check if document exists
            guard let documents = snapshot else {
                return
            }
            
            // Check user document for likers Id
            if(documents.get("liked") as? [String] ?? [String]()).contains(currentUser.id) {
                // Add match to both users
                self.db.collection("users").document(currentUser.id).updateData(
                    ["matches": FieldValue.arrayUnion([user.id])])
                self.db.collection("users").document(user.id).updateData(
                    ["matches": FieldValue.arrayUnion([currentUser.id])])
                
                // Remove user from likees list
                self.db.collection("users").document(user.id).updateData(
                    ["liked": FieldValue.arrayRemove([currentUser.id])])
            } else {
                // Add likee to likers list
                self.db.collection("users").document(currentUser.id).updateData(
                    ["liked": FieldValue.arrayUnion([user.id])])
            }
        }
    }
    
    func dislike(user: User) {
        // Check if current user is nil
        guard let currentUser = self.currentUser else {
            return
        }
        
        // Add disliked user to current user's disliked list
        db.collection("users").document(currentUser.id).updateData(
            ["disliked": FieldValue.arrayUnion([user.id])])
    }
}
