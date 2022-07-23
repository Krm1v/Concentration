//
//  Concentration.swift
//  Concentration
//
//  Created by Владислав Баранкевич on 20.07.2022.
//

import Foundation

struct Concentration {
    
    //MARK: - Properties
    
    private(set) var cards = [Card]()
    private var indexOfOneAndOnlyFacedUpCard: Int? {
        
        get {
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }

    private(set) var score = 0
    private var seenCards: Set<Int> = []
    private(set) var flipCount = 0
    
    //MARK: - Methods
    
    mutating func chooseCard(at index: Int) {
        
        if !cards[index].isMatched {
            flipCount += 1
            if let matchedIndex = indexOfOneAndOnlyFacedUpCard, matchedIndex != index {
                if cards[matchedIndex].identifier == cards[index].identifier {
                    cards[matchedIndex].isMatched = true
                    cards[index].isMatched = true
                    score += Points.matchBonus
                } else {
                    if seenCards.contains(index) {
                        score -= Points.missMatchPenalty
                    }
                    if seenCards.contains(matchedIndex) {
                        score -= Points.missMatchPenalty
                    }
                    seenCards.insert(index)
                    seenCards.insert(matchedIndex)
                }
                cards[index].isFaceUp = true
            } else {
                indexOfOneAndOnlyFacedUpCard = index
            }
        }
    }
    
    mutating func resetGame() {
        
        for index in cards.indices {
            cards[index].isFaceUp = false
            cards[index].isMatched = false
            score = 0
            flipCount = 0
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }
}

extension Collection {
    
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
