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
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
           RootView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool
    {
        FirebaseApp.configure()
        return true
    }
}
