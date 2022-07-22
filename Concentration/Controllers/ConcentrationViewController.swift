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
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var themeTitleLabel: UILabel!
    
    //MARK: - Properties
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    private var numberOfPairsOfCards: Int { return (cardButtons.count + 1) / 2 }
    private var themes = Emoji()
    
    //MARK: - UIView lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        themes.indexTheme = themes.keys.count.arc4random
        setupUI()
    }
    
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
        flipCountLabel.text = "Flips: \(game.flipCount)"
        scoreLabel.text = "Score: \(game.score)"
        themeTitleLabel.text = themes.keys[themes.indexTheme]
    }
    
    private func emoji(for card: Card) -> String {
        
        if themes.emoji[card.identifier] == nil, themes.emojiChoices.count > 0 {
            themes.emoji[card.identifier] = themes.emojiChoices.remove(at: themes.emojiChoices.count.arc4random)
        }
        return themes.emoji[card.identifier] ?? "?"
    }
    
    private func setupUI() {
        cardButtons.forEach { button in
            button.layer.cornerRadius = 15
        }
    }
    
    //MARK: - Action
    
    @IBAction private func cardTouch(_ sender: UIButton) {
        
        guard let cardNumber = cardButtons.firstIndex(of: sender) else { return }
        game.chooseCard(at: cardNumber)
        updateViewFromModel()
    }
    
    @IBAction private func newGameButtonPressed() {
        game.resetGame()
        themes.indexTheme = themes.keys.count.arc4random
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
