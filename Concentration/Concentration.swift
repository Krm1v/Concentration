//
//  Concentration.swift
//  Concentration
//
//  Created by Владислав Баранкевич on 20.07.2022.
//

import Foundation

class Concentration {
    
    var cards = [Card]()
    
    func chooseCard(at index: Int) {
        cards[index].isFaceUp = cards[index].isFaceUp ? false : true
    }
    
    init(numberOfPairsOfCards: Int) {
        
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        // TODO: Shuffle the cards
        cards.shuffle()
    }
}
