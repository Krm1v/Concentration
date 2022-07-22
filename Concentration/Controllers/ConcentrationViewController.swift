//
//  ViewController.swift
//  Concentration
//
//  Created by Владислав Баранкевич on 20.07.2022.
//

import UIKit

class ConcentrationViewController: UIViewController {
    
    //MARK: - @IBOutlets
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    @IBOutlet private var cardButtons: [UIButton]!
    
    //MARK: - Properties
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    private var numberOfPairsOfCards: Int { return (cardButtons.count + 1) / 2 }
    private var emojiChoices = ["👻", "🦇", "🧙‍♀️", "🎃", "🍭", "😈", "🍬", "🍎", "😱"]
    private(set) var flipCount = 0 { didSet { flipCountLabel.text = "Flips: \(flipCount)" }
    }
    private var emoji = [Int:String]()
    
    //MARK: - Methods
    
    private func updateViewFromModel() {
        
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    
    private func emoji(for card: Card) -> String {
        
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            emoji[card.identifier] = emojiChoices.remove(at: emojiChoices.count.arc4random)
        }
        return emoji[card.identifier] ?? "?"
    }
    //MARK: - Action
    
    @IBAction private func cardTouch(_ sender: UIButton) {
        
        flipCount += 1
        guard let cardNumber = cardButtons.firstIndex(of: sender) else { return }
        game.chooseCard(at: cardNumber)
        updateViewFromModel()
    }
    
    
}

extension Int {
    
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
