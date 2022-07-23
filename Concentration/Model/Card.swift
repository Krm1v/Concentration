//
//  Card.swift
//  Concentration
//
//  Created by Владислав Баранкевич on 20.07.2022.
//

import Foundation

struct Card {
    
    private static var identifierFactory = 0
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    private static func createUniqueIdentifier() -> Int {
        
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        
        self.identifier = Card.createUniqueIdentifier()
    }
}
