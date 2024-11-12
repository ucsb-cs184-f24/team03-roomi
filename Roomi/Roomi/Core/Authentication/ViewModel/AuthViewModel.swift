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
    @Published var potentialUsers = [User]()
    @Published var likedList = [User]()
    @Published var matchList = [User]()
    @Published var dislikeList = [User]()
    @Published var isLoading = false
    
    private let db = Firestore.firestore()
    
    init() {
        self.userSession = Auth.auth().currentUser
        Task {
            await fetchUser()
            await getAllUsers()
            await getAllLikes()
            await getAllMatches()
            getAllPotentialUsers()
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
    
    func getAllUsers() async {
        print("Getting all users")
        self.isLoading = true
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
            self.isLoading = false
        }
        self.isLoading = false
    }
    
    // Users the current user has not liked, matched, or disliked
    func getAllPotentialUsers() {
        print("Getting all potential users")
        
        // Check if current user is nil
        guard let currentUser = self.currentUser else {
            return
        }
        
        // Filter out users that are liked, matched, or disliked
        self.potentialUsers = self.userList.filter { user in
            !self.likedList.contains(where: { $0.id == user.id }) &&
            !self.matchList.contains(where: { $0.id == user.id }) &&
            !self.dislikeList.contains(where: { $0.id == user.id }) && user.id != currentUser.id
        }
        
    }
    
    func like(otherUser: User) async {
        print("Liking user")
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
        print("Disliking user")
        self.isLoading = true
        guard let currentUser = self.currentUser else {
            return
        }
        
        let currentUserRef = db.collection("users").document(currentUser.id)
        do {
            try await currentUserRef.updateData(["disliked": FieldValue.arrayUnion([otherUser.id as String])])
            self.dislikeList.append(otherUser)
            self.potentialUsers.removeAll { $0.id == otherUser.id }
        } catch {
            print("Error adding disliked user: \(error)")
            self.isLoading = false
        }
        
        self.isLoading = false
    }
    
    func getAllLikes() async {
        print("Getting all liked users")
        self.isLoading = true
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
            self.isLoading = false
        }
        self.isLoading = false
    }
    
    func getAllMatches() async {
        print("Getting all matched users")
        self.isLoading = true
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
            self.isLoading = false
        }
        self.isLoading = false
    }
}
