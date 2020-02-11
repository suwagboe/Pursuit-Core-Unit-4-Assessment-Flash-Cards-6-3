//
//  cardModel.swift
//  Unit4Assessment
//
//  Created by Pursuit on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import Foundation

struct Cards: Codable & Equatable{
    let cardListType: String
    let cards: [CardData]
}

struct CardData: Codable & Equatable {
    let id: Int
    let cardTitle: String
    let facts: [String]
    let userId: String?
}
