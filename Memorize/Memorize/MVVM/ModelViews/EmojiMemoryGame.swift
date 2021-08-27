//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Gabriel on 7/31/21.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    @Published private var gameViewModel: MemoryGame<String> = EmojiMemoryGame
        .createMemoryGame(theme: chosenTheme)
    
    private(set) static var chosenTheme = EmojiThemesList.chooseRandomTheme()
    
    private static func createMemoryGame(theme: EmojiTheme) -> MemoryGame<String> {
        
        assert(theme.gameElements.count >= 6,
               "Number of emojis in current theme should be >6")
        
        let emojis: Array<String> = theme.gameElements.shuffled()
        
        return MemoryGame<String>(numberOfPairsOfCards: theme.numberOfCards,
                                  theme: chosenTheme) { pairIndex in
            return emojis[pairIndex]
        }
    }
    
    // MARK: - Access to the Model
    
    var cards: Array<MemoryGame<String>.Card> { gameViewModel.cards }
    
    var points: Int { gameViewModel.points }
    
    var theme: EmojiTheme { gameViewModel.theme }
    
    // MARK: - Intents

    func choose(card: MemoryGame<String>.Card) {
        gameViewModel.choose(card: card)
    }
    
    func rebuild() {
        EmojiMemoryGame.chosenTheme = EmojiThemesList.chooseRandomTheme()
        gameViewModel.rebuild()
        gameViewModel = EmojiMemoryGame.createMemoryGame(
                            theme: EmojiMemoryGame.chosenTheme)
    }
    
}


