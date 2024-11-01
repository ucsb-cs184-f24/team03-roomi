//
//  Profile.swift
//  Roomi
//
//  Created by Khang Chung on 10/31/24.
//

import SwiftUI

struct Profile: Identifiable {
    let id = UUID()
    let name: String
    let age: Int
    let gender: String
    let location: String
    let image: String
    let bio: String
}

