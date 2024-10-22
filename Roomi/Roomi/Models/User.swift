//
//  User.swift
//  Roomi
//
//  Created by Alec Morrison on 10/21/24.
//

import Foundation

struct User: Codable {
    let id: String
    let name: String
    let email: String
    let joined: TimeInterval
}
