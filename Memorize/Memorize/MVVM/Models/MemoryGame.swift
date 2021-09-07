//
//  MemoryGame.swift
//  Memorize
//
//  Created by Gabriel on 7/31/21.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    private(set) var points = 0
    private(set) var theme: EmojiTheme
    
    private var matchedTwoCards = false
    
    init(numberOfPairsOfCards: Int, theme: EmojiTheme,
         cardContentFactory: (Int) -> CardContent) {
        self.theme = theme
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
        cards = cards.shuffled()
    }
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        //loops through each card and if `.isFaceUp` and `.only` returns the card index
        get { cards.indices.filter { cards[$0].isFaceUp }.only }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    mutating func rebuild() {
        cards = cards.shuffled()
        points = 0
        for index in cards.indices {
            cards[index].wasSeen = false
            cards[index].isMatched = false
            cards[index].isFaceUp = false
        }
    }
    
    mutating func choose(card: Card) {
        
        let rightChoicePointAward: Int = 2
        let sawSameCardAgainPointPenalty: Int = 1
        
        if let chosenIndex = cards.firstIndex(where: { chosenCard in chosenCard.id == card.id }) {
            if !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                        matchedTwoCards = true
                        points += rightChoicePointAward
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                        cards[chosenIndex].wasSeen = true
                    }
                    if !matchedTwoCards {
                        if cards[chosenIndex].wasSeen {
                            points -= sawSameCardAgainPointPenalty
                        }
                        if cards[potentialMatchIndex].wasSeen {
                            points -= sawSameCardAgainPointPenalty
                        }
                    }
                    cards[chosenIndex].isFaceUp = !cards[chosenIndex].isFaceUp
                    cards[chosenIndex].wasSeen = true
                    cards[potentialMatchIndex].wasSeen = true
                } else {
                    matchedTwoCards = false
                    indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                }
            }
        }
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false {
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        var isMatched: Bool = false {
            didSet {
                stopUsingBonusTime()
            }
        }
        var wasSeen: Bool = false
        var content: CardContent
        var id: Int
        
        
        
        // MARK: - Bonus Time
        
        // A time marker for of bonus time
        // that starts counting towards 0
        // once the user sees the card face
        
        // Can be zero when no bonus time available for this card
        var bonusTimeLimit: TimeInterval = 6
        
        // How long this card has been face up
        private var faceUpTime: TimeInterval {
            if let lastFaceUpDate = self.lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }
        
        // The last time this card was turned face up (and is still face up)
        var lastFaceUpDate: Date?
        // The acumulated time this card has been face up in the past
        // not including the current time it`s been face up if it`s currently so
        var pastFaceUpTime: TimeInterval = 0
        
        // How much time left before the bonus time runs out
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }
        
        // Percentage of bonus time remaining
        var bonusRemaining: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining/bonusTimeLimit : 0
        }
        
        // Whether the card was matched during bonus time period
        var hasEarnedBonus: Bool {
            isMatched && bonusTimeRemaining > 0
        }
        
        // Whether we`re currently face up, unmatched and have not yet used up bonus time
        var isConsumingBonusTime: Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }
        
        // Called when the card transitions to face up state
        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            self.lastFaceUpDate = nil
        }
        
    }
}
