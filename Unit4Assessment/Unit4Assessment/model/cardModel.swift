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

extension Cards {
    
    static func getData() -> [CardData] {
                
        var holdingCardData = [CardData]()
        
        guard let fileURL = Bundle.main.url(forResource: "cardData", withExtension: "json") else {
            fatalError("couldnt locate json files SORRHYY")
        }
        
        do {
            
            let data = try Data(contentsOf: fileURL)
            
            let actualData = try JSONDecoder().decode(Cards.self, from: data)
            
           holdingCardData = actualData.cards
            
        } catch {
            
            fatalError("could not catch the data.. be better.. \(error)")
            
        }
        return holdingCardData
    }
    
}
