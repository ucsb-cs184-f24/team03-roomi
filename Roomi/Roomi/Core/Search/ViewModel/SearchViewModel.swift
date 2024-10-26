//
//  SearchViewModel.swift
//  Roomi
//
//  Created by Benjamin Conte on 10/26/24.
//

import Foundation
import FirebaseFirestore

@MainActor
class SearchViewModel: ObservableObject {
    
    @Published var profileList = [Profile]()
    
    func getProfiles() {
        
        // Get reference to Database
        let db = Firestore.firestore()
        
        // Read in documents
        db.collection("Users").getDocuments { snapshot, error in
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
            self.profileList =  documents.map { profile in
                return Profile(id: profile.documentID, fullname: profile["fullname"] as? String ?? "", location: profile["location"] as? String ?? "", hobby: profile["hobby"] as? String ?? "", age: profile["age"] as? Int ?? 0)
            }
        }
    }
}
