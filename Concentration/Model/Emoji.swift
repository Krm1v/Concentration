//
//  Emoji.swift
//  Concentration
//
//  Created by Владислав Баранкевич on 22.07.2022.
//

import Foundation

struct Emoji {
    
    private(set) var emojiByThemes = [
        "Haloween" : ["👻", "🦇", "🧙‍♀️", "🎃", "🍭", "😈", "🍬", "🍎", "😱", "☠️"],
        "Sport" : ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏐", "🏉", "🎱", "🏓"],
        "Animals" : ["🐶", "🐱", "🐭", "🐹", "🦊", "🐻‍❄️", "🦁", "🐵", "🐻", "🐷"],
        "Faces" : ["😁", "😅", "😇", "😜", "🥶", "😑", "🤬", "🥺", "😳", "🙄"],
        "Countries" : ["🇺🇦", "🇵🇱", "🇱🇹", "🇱🇻", "🇬🇧", "🇺🇸", "🇳🇴", "🇩🇰", "🇫🇮", "🇯🇵"],
        "Food" : ["🍟", "🍔", "🌭", "🍕", "🍗", "🍜", "🥃", "🍺", "🍣", "🍦"]
    ]
    
    var keys: [String] {
        return Array(emojiByThemes.keys)
    }
    var indexTheme = 0 {
        didSet {
            emojiChoices = emojiByThemes[keys[indexTheme]] ?? []
            emoji = [Int:String]()
        }
    }
    var emojiChoices = [String]()
    var emoji = [Int:String]()
    
}
