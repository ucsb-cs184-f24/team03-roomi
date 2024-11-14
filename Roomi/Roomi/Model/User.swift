//
//  User.swift
//  Roomi
//
//  Created by Anderson Lee on 10/22/24.
//

import Foundation

struct User: Identifiable, Codable {
    var id: String
    var email: String
    var name: String
    var age: Int
    var gender: String
    var phoneNumber: String
    var likes: Set<String>
    var dislikes: Set<String>
    var matches: [String]
}
