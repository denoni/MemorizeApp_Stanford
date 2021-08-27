//
//  EmojiMemoryGameTheme.swift
//  Memorize
//
//  Created by Gabriel on 8/16/21.
//

import SwiftUI

struct EmojiTheme {
        let gameThemeName: String
        let gameElements: [String]
        let cardColor: Color
        var numberOfCards:Int {
            let randomNumber = Int.random(in: 2...6)
            if randomNumber != 5 { return randomNumber } else { return 6 }
        }
}

struct EmojiThemesList {
    
    static func chooseRandomTheme() -> EmojiTheme {
        EmojiThemesList.randomTheme[
            Int.random(in: 0..<EmojiThemesList.randomTheme.count)]
    }
    
    private static var randomTheme = [animalTheme1, animalTheme2, animalTheme3,
                                      foodTheme, clothesTheme, halloweenTheme]
    
    
    static let animalTheme1: EmojiTheme = EmojiTheme.init(gameThemeName: "Animals 1",
                                         gameElements: ["🐵", "🐸", "🐷", "🐶",
                                                        "🐭", "🦊", "🐯", "🦁"],
                                         cardColor: Color.green)
    
    static let animalTheme2: EmojiTheme = EmojiTheme.init(gameThemeName: "Animals 2",
                                         gameElements: ["🐥", "🦆", "🦉", "🦄",
                                                        "🐝", "🦋", "🐌", "🐞"],
                                         cardColor: Color.yellow)
    
    static let animalTheme3: EmojiTheme = EmojiTheme.init(gameThemeName: "Animals 3",
                                         gameElements: ["🐢", "🐍", "🦖", "🦕",
                                                        "🐙", "🦞", "🦐", "🦀"],
                                         cardColor: Color.green)
    
    static let foodTheme: EmojiTheme = EmojiTheme.init(gameThemeName: "Foods & Drinks",
                                         gameElements: ["🥤", "🍪", "🍿", "🍭",
                                                        "🍔", "🥜", "🧃", "☕️"],
                                         cardColor: Color.red)
    
    static let clothesTheme: EmojiTheme = EmojiTheme.init(gameThemeName: "Clothes",
                                         gameElements: ["🧤", "👔", "👠", "👗",
                                                        "🩳", "🎩", "👢", "👟"],
                                         cardColor: Color.pink)
    
    static let halloweenTheme: EmojiTheme = EmojiTheme.init(gameThemeName: "Halloween",
                                         gameElements: ["🎃", "👻", "💀", "🕸",
                                                        "🕷", "🍬", "🍭", "🩸"],
                                         cardColor: Color.orange)
        
}

    
    
    
    





