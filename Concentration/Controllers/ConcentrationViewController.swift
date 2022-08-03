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
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private weak var themeTitleLabel: UILabel!
    @IBOutlet weak var newGameButton: UIButton!
    
    //MARK: - Properties
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    private var numberOfPairsOfCards: Int { return (cardButtons.count + 1) / 2 }
    private var themes = Theme()
    private var primaryColor = UIColor(red: 130/255, green: 42/255, blue: 111/255, alpha: 1)
    private var secondaryColor = UIColor(red: 98/255, green: 39/255, blue: 201/255, alpha: 1)
    
    //MARK: - UIView lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        themes.indexTheme = themes.keys.count.arc4random
        setupUIForCards()
        setupUIForLabelsAndNewGameButton()
        addVerticalGradientLayer(topcolor: primaryColor, bottomColor: secondaryColor)
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
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : .systemPurple
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
    
    private func setupUIForCards() {
        cardButtons.forEach { button in
            button.layer.cornerRadius = 15
        }
    }
    
    private func animateButton(_ sender: UIButton) {
        
        UIView.transition(with: sender,
                          duration: 0.6,
                          options: [.transitionFlipFromLeft]) {
            self.updateViewFromModel()
        }
    }
    
    private func setupUIForLabelsAndNewGameButton() {
        let attributes: [NSAttributedString.Key : Any] = [
            .strokeColor : UIColor.white,
            .strokeWidth : 5.0
        ]
        let attributedTitleForScoreLabel = NSAttributedString(string: "Score: 0",
                                                              attributes: attributes)
        let attributedTitleForFlipsLabel = NSAttributedString(string: "Flips: 0",
                                                              attributes: attributes)
        let attributedTitleForNewGameButton = NSAttributedString(string: "New game",
                                                                 attributes: attributes)
        scoreLabel.attributedText = attributedTitleForScoreLabel
        flipCountLabel.attributedText = attributedTitleForFlipsLabel
        newGameButton.setAttributedTitle(attributedTitleForNewGameButton,
                                         for: .normal)
    }
    
    //MARK: - Action
    
    @IBAction private func cardTouch(_ sender: UIButton) {
        
        guard let cardNumber = cardButtons.firstIndex(of: sender) else { return }
        game.chooseCard(at: cardNumber)
        animateButton(sender)
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

fileprivate extension ConcentrationViewController {
    
    func addVerticalGradientLayer(topcolor: UIColor,
                                  bottomColor: UIColor) {
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [topcolor.cgColor, bottomColor.cgColor]
        gradient.locations = [0.0, 1.0]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        view.layer.insertSublayer(gradient, at: 0)
    }
}
