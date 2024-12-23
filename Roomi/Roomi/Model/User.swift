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
    var schoolWork: String
    var bio: String
    var social: String
    var drugs: String
    var petFriendly: Bool
    var imageKey: String? // Optional to handle cases where no profile image is uploaded

}
