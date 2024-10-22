//
//  RoomiApp.swift
//  Roomi
//
//  Created by Alec Morrison on 10/11/24.
//

import SwiftUI
import FirebaseCore

@main
struct RoomiApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
