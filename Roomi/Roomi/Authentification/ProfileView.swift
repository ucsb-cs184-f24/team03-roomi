//
//  ProfileView.swift
//  Roomi
//
//  Created by Braden Castillo on 10/19/24.
//

import SwiftUI
import FirebaseAuth

@MainActor
final class ProfileViewModel: ObservableObject {
    /*
    func signOut() throws {
        try AuthManager.shared.signOut()
    }
    
    func getCurrentUserEmail() -> String {
            Auth.auth().currentUser?.email ?? "No Email"
        }
    */
    @Published var userEmail: String?
        private var authStateListenerHandle: AuthStateDidChangeListenerHandle?
        
        init() {
            setUpAuthStateListener()
        }
        
        // Set up a listener to track changes to authentication state
        func setUpAuthStateListener() {
            authStateListenerHandle = Auth.auth().addStateDidChangeListener { [weak self] _, user in
                // Whenever the user logs in or out, this gets triggered
                self?.userEmail = user?.email
            }
        }
        
        func signOut() throws {
            try AuthManager.shared.signOut()
            // Sign out is handled here; email will be automatically reset by the auth listener
        }
        
        deinit {
            // Remove the auth listener when the view model is deinitialized
            if let handle = authStateListenerHandle {
                Auth.auth().removeStateDidChangeListener(handle)
            }
        }
}

struct ProfileView: View {
    
    @StateObject private var viewModel = ProfileViewModel()
    @Binding var showSignInView: Bool
    
    //let authUser = try? AuthManager.shared.getAuthenticatedUser()
    
    var body: some View {
        List {
            Button("Log out") {
                Task {
                    do {
                        try viewModel.signOut()
                        showSignInView = true
                    } catch {
                        print(error)
                    }
                }
            }
            
            NavigationLink("About Roomi") {
                AboutView()
            }
        }
        //.navigationBarTitle(Auth.auth().currentUser?.email ?? "No Email")
        //.navigationBarTitle(authUser?.email ?? "No Email")
        .navigationBarTitle(viewModel.userEmail ?? "No Email Found")
    }
}

#Preview {
    NavigationStack{
        ProfileView(showSignInView: .constant(false))
    }
}
