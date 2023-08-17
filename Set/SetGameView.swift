//
//  ContentView.swift
//  Set
//
//  Created by Oliver Hnát on 08.04.2023.
//

import SwiftUI

struct SetGameView: View {
    
    @ObservedObject var game: SetGameModelView
    var body: some View {
        VStack {
            ScrollOrAspectVGrid()
            Spacer()
            Spacer()
            VStack {
                Button(action: {game.deal()}, label: { Text("Deal 3 more cards").font(.largeTitle) })
                HStack {
                    Button(action: {game.newGame()}, label: {Text("New game").font(.largeTitle)}).padding()
                    Spacer()
                    Text("\(game.score)").font(.largeTitle).bold()
                }
            }
        }
    }
    
    @ViewBuilder
    private func ScrollOrAspectVGrid() -> some View {
        if (game.cardsOnTable.count <= 21) {
                AspectVGrid(items: game.cardsOnTable, aspectRatio: 2/3) { card in
                    CardView(card: card, colors: game.colors).foregroundColor(.red).onTapGesture {
                        game.choose(card)
                    }
                }
        }
        else {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 70), spacing: 0)], spacing: 0) {
                    ForEach(game.cardsOnTable) { card in
                        CardView(card: card, colors: game.colors)
                            .aspectRatio(2/3, contentMode: .fit)
                            .foregroundColor(.red)
                            .onTapGesture {
                            game.choose(card)
                        }
                    }
                }
            }
        }
    }
}


struct CardView: View {
    var colors: [Int : Color]
    var card: SetGameModelView.Card
    var numberOfSymbols: Int
    var color: Color
    var symbol: CardSymbol
    var shading: CardShading
    var selectedGreen: Color = Color(hue: 0.355, saturation: 1.0, brightness: 1.0)
    
    init(card: SetGameModelView.Card, colors: [Int : Color]) {
        self.card = card
        self.numberOfSymbols = card.numberOnCard
        self.color = card.color
        self.symbol = card.symbol
        self.shading = card.shading
        self.colors = colors;
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let cardShape = RoundedRectangle(cornerRadius: 10)
                cardShape.aspectRatio(2/3, contentMode: .fit)
                if (card.isSelected) {
                    cardShape.foregroundColor(selectedGreen)
                } else if (card.isMatched) {
                    cardShape.foregroundColor(colors[card.matchId])
                } else {
                    cardShape.foregroundColor(.white)
                }
                cardShape.strokeBorder(lineWidth: 5)
                
                VStack {
                    ForEach (0..<numberOfSymbols, id: \.self) { _ in
                        createShape(height: geometry.size.height / 4)
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private func createShape(height: CGFloat) -> some View {
        switch symbol {
        case .diamond:
            colorShape(Diamond())
                .frame(height: height)
        case .squiggles:
            colorShape(Rectangle())
                .frame(height: height)
        default:
            colorShape(RoundedRectangle(cornerRadius: 100))
                .frame(height: height)
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
        let game = SetGameModelView()
        SetGameView(game: game)
            .preferredColorScheme(.dark)
        SetGameView(game: game)
    }
}
