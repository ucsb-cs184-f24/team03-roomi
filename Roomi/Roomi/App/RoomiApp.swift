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
    @StateObject var authViewModel = AuthViewModel()
    @StateObject var cardsViewModel = CardsViewModel(service: CardService())
    
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authViewModel)
                .environmentObject(cardsViewModel)
        }
    }
}
