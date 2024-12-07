//
//  User.swift
//  Roomi
//
//  Created by Anderson Lee on 10/22/24.
//

import Foundation

struct User: Identifiable, Codable, Hashable {
    var id: String
    var email: String
    var name: String
    var age: Int
    var gender: String
    var phoneNumber: String
    var imageKey: String? // Optional to handle cases where no profile image is uploaded
    var schoolWork: String // School or work-related information
    var bio: String // User's bio
    var social: String // Social trait (Introverted, Extroverted, Both)
    var drugs: String // Alcohol/420 preferences
    var petFriendly: Bool // Whether the user is pet-friendly
}
