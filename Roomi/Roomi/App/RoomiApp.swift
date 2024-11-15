//
//  RoomiApp.swift
//  Roomi
//
//  Created by Alec Morrison on 10/11/24.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct RoomiApp: App {
    @StateObject var authViewModel = AuthViewModel()
    @StateObject var searchViewModel = SearchViewModel()
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var cardsViewModel = CardsViewModel(service: CardService())    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(searchViewModel)
                .environmentObject(authViewModel)
                .environmentObject(cardsViewModel)
        }
    }
}
