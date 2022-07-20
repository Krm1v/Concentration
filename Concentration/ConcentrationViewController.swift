//
//  ViewController.swift
//  Concentration
//
//  Created by Владислав Баранкевич on 20.07.2022.
//

import UIKit

class ConcentrationViewController: UIViewController {
    
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    private var emojiChoices = ["👻", "🦇", "🧙‍♀️", "🎃", "🍭", "😈", "🍬", "🍎", "😱"]
    private var flipCount = 0 { didSet { flipCountLabel.text = "Flips: \(flipCount)" }
    }
    private var emoji = [Int:String]()
    
    //MARK: - Action
    
    @IBAction private func cardTouch(_ sender: UIButton) {
        
        flipCount += 1
        guard let cardNumber = cardButtons.firstIndex(of: sender) else { return }
        game.chooseCard(at: cardNumber)
        updateViewFromModel()
        
    }
    
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
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
}


