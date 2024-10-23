//
//  User.swift
//  Roomi
//
//  Created by Anderson Lee on 10/22/24.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    let email: String
    let firstName: String
    let lastName: String
}
