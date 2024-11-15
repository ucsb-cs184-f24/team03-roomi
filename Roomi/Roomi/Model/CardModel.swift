//
//  CardModel.swift
//  Roomi
//
//  Created by Alec Morrison on 11/8/24.
//

import Foundation

struct CardModel {
    let user: User
}

extension CardModel: Identifiable, Hashable{
    var id: String { return user.id }
}
