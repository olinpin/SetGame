//
//  ContentView.swift
//  Set
//
//  Created by Oliver Hnát on 08.04.2023.
//

import SwiftUI

struct SetGameView: View {
    
    var game: SetGame
    var body: some View {
        VStack {
            AspectVGrid(items: game.cardsOnTable, aspectRatio: 2/3) { card in
                CardView(card: card).foregroundColor(.red)
            }
            Spacer()
            Spacer()
//            Button(action: {game.newGame()}, label: {Text("New game")})
        }
    }
    
}


struct CardView: View {
    var card: SetGame.Card
    var numberOfSymbols: Int
    var color: Color
    var symbol: CardSymbol
    var shading: CardShading
    
    init(card: SetGame.Card) {
        self.card = card
        self.numberOfSymbols = card.numberOnCard
        self.color = card.color
        self.symbol = card.symbol
        self.shading = card.shading
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let cardShape = RoundedRectangle(cornerRadius: 10)
                cardShape.aspectRatio(2/3, contentMode: .fit)
                cardShape.foregroundColor(.white)
                cardShape.strokeBorder(lineWidth: 5)
                
                if (shading == CardShading.open) {
                }
                VStack {
                    ForEach (0..<numberOfSymbols, id: \.self) { _ in
                        createShape().frame(height: geometry.size.height/4)
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private func createShape() -> some View {
        switch symbol {
        case .diamond:
            colorShape(Diamond())
        case .squiggles:
            colorShape(Rectangle())
        default:
            colorShape(RoundedRectangle(cornerRadius: 100))
        }
    }
    
    @ViewBuilder
    private func colorShape(_ shape: some Shape) -> some View {
        opacityShape(shape).foregroundColor(color).padding(.horizontal)
    }
    
    @ViewBuilder
    private func opacityShape(_ shape: some Shape) -> some View {
        switch shading {
        case .solid:
            shape.stroke(lineWidth: 2.5)
        case .striped:
            shape.opacity(0.5)
        default:
            shape
        }
    }
}







struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = SetGame()
        SetGameView(game: game)
            .preferredColorScheme(.dark)
        SetGameView(game: game)
    }
}
