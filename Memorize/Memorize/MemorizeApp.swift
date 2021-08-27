//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Gabriel on 7/30/21.
//

import SwiftUI

@main
struct MemorizeApp: App {
    var body: some Scene {
        WindowGroup {
            let game = EmojiMemoryGame()
            EmojiMemoryGameView(gameViewModel: game)
        }
    }
}
