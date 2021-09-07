//
//  ContentView.swift
//  Memorize
//
//  Created by Gabriel on 7/30/21.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var gameViewModel: EmojiMemoryGame
    
    var body: some View {
        Group{
            Text(gameViewModel.theme.gameThemeName)
                .bold().font(Font.largeTitle)
            Text("Points: \(gameViewModel.points)")
                .font(Font.title2)
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                ForEach(gameViewModel.cards) { card in
                    CardView(card: card).onTapGesture {
                        withAnimation(.easeInOut(duration: card3DRotationDuration)) {
                            gameViewModel.choose(card: card)
                        }
                    }.padding(cardPadding)
                    .aspectRatio(5/6, contentMode: .fit)
              }
            }.padding()
            .foregroundColor(gameViewModel.theme.cardColor)
            RoundedButton.init(text: newGameButtonText,
                               action: { withAnimation(.easeInOut(duration: shuffleDuration)) {
                                    gameViewModel.rebuild() }
            })
      }
  }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedBonusRemaining = 0
        }
    }
    
    @State private var animatedBonusRemaining: Double = 0
    
    var body: some View {
        GeometryReader { geometry in
            if card.isFaceUp || !card.isMatched {
                ZStack {
                    Group {
                        if card.isConsumingBonusTime {
                            buildPieConsumingBonusTime(
                                bonusTime: animatedBonusRemaining)
                            .onAppear { self.startBonusTimeAnimation() }
                        } else {
                            buildPieNotConsumingBonusTime(
                                whereBonusTimeStopped: card.bonusRemaining)
                        }
                    }.padding(cardInternalPadding)
                    .opacity(cardPieOpacity)
                    .transition(.identity)
                    
                    Text(card.content)
                        .font(Font.system(size: fontSize(for: geometry.size)))
                }
                .cardify(isFaceUp: card.isFaceUp)
                .transition(AnyTransition.scale)                
            }
        }
    }
}



    // MARK: - Constants

    private let newGameButtonText = "New Game!"

    private let cardPadding: CGFloat = 5.0
    private let cardInternalPadding: CGFloat = 8.0

    private let card3DRotationDuration = 0.75
    private let shuffleDuration = 0.5

    private let cardPieOpacity: Double = 0.4

    private let fontScaleFactor: CGFloat = 0.75

    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * fontScaleFactor
    }



    // MARK: - Functions

    func buildPieConsumingBonusTime(bonusTime: Double)
    -> some View {
        Pie(startAngle: Angle.degrees(0-90),
            endAngle: Angle.degrees(-bonusTime * 360 - 90))
    }

    func buildPieNotConsumingBonusTime(whereBonusTimeStopped: Double)
    -> some View {
        Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-whereBonusTimeStopped * 360 - 90))
    }



    // MARK: - Previews

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game: EmojiMemoryGame = EmojiMemoryGame()
        game.choose(card: game.cards[0])
        return EmojiMemoryGameView(gameViewModel: game)
    }
}
