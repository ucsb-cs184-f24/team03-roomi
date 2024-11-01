//
//  UserRelationshipsViewModel.swift
//  Roomi
//
//  Created by Anderson Lee on 11/1/24.
//

import Foundation
import FirebaseFirestore

class UserRelationshipsViewModel: ObservableObject {
    @Published var likes = Set<String>()
    @Published var dislikes = Set<String>()
    @Published var matches = [String]()
}
