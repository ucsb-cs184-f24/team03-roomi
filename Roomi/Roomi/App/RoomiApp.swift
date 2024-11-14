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
    @StateObject var searchViewModel = SearchViewModel()
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
                .environmentObject(searchViewModel)
        }
    }
}
