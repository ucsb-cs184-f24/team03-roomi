//
//  RoomiApp.swift
//  Roomi
//
//  Created by Alec Morrison on 10/11/24.
//

import SwiftUI
import Firebase

@main
struct RoomiApp: App {
    @StateObject var viewModel = AuthViewModel()
    @StateObject var userRelationshipsViewModel = UserRelationshipsViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
                .environmentObject(userRelationshipsViewModel)
        }
    }
}
