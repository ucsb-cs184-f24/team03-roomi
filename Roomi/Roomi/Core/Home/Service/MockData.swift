//
//  MockData.swift
//  Roomi
//
//  Created by Alec Morrison on 11/8/24.
//

import Foundation

struct MockData {
    static let users: [User] = [
        .init(
            id: NSUUID().uuidString,
            email: "email",
            name: "Joe",
            age: 21,
            gender: "Male",
            phoneNumber: "phone #",
            schoolWork: "",
            bio: "",
            social: "",
            drugs: "",
            petFriendly: true
        ),
        .init(
            id: NSUUID().uuidString,
            email: "email",
            name: "Megan",
            age: 30,
            gender: "Female",
            phoneNumber: "phone #",
            schoolWork: "",
            bio: "",
            social: "",
            drugs: "",
            petFriendly: true
        ),
        .init(
            id: NSUUID().uuidString,
            email: "email",
            name: "Bob",
            age: 27,
            gender: "Male",
            phoneNumber: "phone #",
            schoolWork: "",
            bio: "",
            social: "",
            drugs: "",
            petFriendly: true
        ),
        
    ]
}
