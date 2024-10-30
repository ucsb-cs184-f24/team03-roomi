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
}
