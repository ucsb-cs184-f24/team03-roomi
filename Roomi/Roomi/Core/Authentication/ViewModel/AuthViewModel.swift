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
    @Published var potentialUser = User(id: "", email: "", name: "", age: 0, gender: "male", phoneNumber: "", schoolWork: "", bio: "", social: "", drugs: "", petFriendly: true)
    @Published var password = ""
    @Published var errorMessage = ""
    @Published var userList = [User]()
    
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
                            phoneNumber: potentialUser.phoneNumber,
                            schoolWork: potentialUser.schoolWork,
                            bio: potentialUser.bio,
                            social: potentialUser.social,
                            drugs: potentialUser.drugs,
                            petFriendly: potentialUser.petFriendly)
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
            self.potentialUser = User(id: "", email: "", name: "", age: 0, gender: "male", phoneNumber: "", schoolWork: "", bio: "", social: "", drugs: "", petFriendly: true)
            self.password = ""
            self.loginState = true
            
        }
        catch {
            print("DEBUG: Failed to sign out with error: \(error.localizedDescription)")
        }
    }
    
    func updateProfile(user: User) async throws {
        guard let currentUserId = Auth.auth().currentUser?.uid else { return }
        
        let userData: [String: Any] = [
            "name": user.name,
            "age": user.age,
            "gender": user.gender,
            "phoneNumber": user.phoneNumber,
        ]
        
        try await Firestore.firestore().collection("users").document(currentUserId).updateData(userData)
        
        self.currentUser?.name = user.name
        self.currentUser?.age = user.age
        self.currentUser?.gender = user.gender
        self.currentUser?.phoneNumber = user.phoneNumber
        
    }
    
    
    func fetchUser() async {
        do {
            guard let uid = Auth.auth().currentUser?.uid else { return }
            let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
            self.currentUser = try snapshot.data(as: User.self)
            self.potentialUser = self.currentUser!
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
        // Get reference to Database
        let db = Firestore.firestore()
        
        // Read in documents
        db.collection("users").getDocuments { snapshot, error in
            // Check for errors
            if let error {
                print("Error fetching documents: \(error)")
            }
            
            // Check if no documents
            guard let documents = snapshot?.documents else {
                print("No documents fetched")
                return
            }
            
            // Extract profiles
            self.userList =  documents.map { user in
                return User(id: user.documentID, email: user.get("email") as? String ?? "", name: user.get("name") as? String ?? "", age: user.get("age") as? Int ?? 0, gender: user.get("gender") as? String ?? "", phoneNumber: user.get("phoneNumber") as? String ?? "", schoolWork: user.get("schoolWork") as? String ?? "", bio: user.get("bio") as? String ?? "", social: user.get("social") as? String ?? "", drugs: user.get("drugs") as? String ?? "", petFriendly: user.get("petFriendly") as? Bool ?? true)
            }
        }
    }
    
    func clearPotentialUser() {
        potentialUser = User(id: "", email: "", name: "", age: 0, gender: "male", phoneNumber: "", schoolWork: "", bio: "", social: "", drugs: "", petFriendly: true)
        password = ""
        
        print(potentialUser)
        print(password)
    }
}
