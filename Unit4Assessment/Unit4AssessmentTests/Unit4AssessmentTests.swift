//
//  Unit4AssessmentTests.swift
//  Unit4AssessmentTests
//
//  Created by Alex Paul on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import XCTest
@testable import Unit4Assessment


class Unit4AssessmentTests: XCTestCase {

    func testCardsData() {
        let jsonData = """
{
       "id": "1",
       "cardTitle": "What is the difference between a synchronous & an asynchronous task?",
       "facts": [
           "Synchronous: waits until the task have completed.",
           "Asynchronous: completes a task in the background and can notify you when complete."
       ]
   },
   {
       "id": "2",
       "cardTitle": "What is an Enum?",
       "facts": [
           "contains a group of related values.",
           "enumerations define a finite number of states, and can bundle associated values with each individual state.",
           "you can use them to model the state of your app and its internal processes."
       ]
   },
   {
       "id": "3",
       "cardTitle": "What’s the difference between the frame and the bounds?",
       "facts": [
           "The frame of a UIView is the rectangle, expressed as a location (x,y) and size (width,height) relative to the superview it is contained within.",
           "The bounds of a UIView is the rectangle, expressed as a location (x,y) and size (width,height) relative to its own coordinate system (0,0)."
       ]
   }
""".data(using: .utf8)!
        
       struct CardsData: Codable{
            let cardListType: String
            let cards: [Cards]
        }

        struct Cards: Codable{
            let id: String
            let cardTitle: String
            let facts: [String]
           // let userId: String?
        }
        
        let expectedCardTitle = "What is the difference between a synchronous & an asynchronous task?"
        
        // ACT
        do {
            let cardtitle = try JSONDecoder().decode(CardsData.self, from: jsonData)
            
            let firstTitle = cardtitle.cards.first?.cardTitle ?? ""
            XCTAssertEqual(expectedCardTitle, firstTitle)
        } catch {
            XCTFail("This is the reason that it failed: \(error)")
        }
    }
}
