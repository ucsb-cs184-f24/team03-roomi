//
//  AppDelegate.swift
//  Roomi
//
//  Created by Benjamin Conte on 11/7/24.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure() // Initialize Firebase here
        return true
    }
}

