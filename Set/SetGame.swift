//
//  SetGame.swift
//  Set
//
//  Created by Oliver Hnát on 09.04.2023.
//

import Foundation
import SwiftUI

struct SetGame {
    private var deck: Array<Card>
    private(set) var cardsOnTable: Array<Card>

    
    init() {
        var deck = SetGame.createCards()
        deck.shuffle()
        let cardsOnTable = Array(deck[0..<12])
        deck.removeAll { card in
            cardsOnTable.contains { $0 == card }
        }
        self.deck = deck
        self.cardsOnTable = cardsOnTable
    }
    
    private static func createCards() -> Array<SetGame.Card> {
        let colors: Array<Color> = [.blue, .green, .red]
        var deck: Array<SetGame.Card> = Array()
        var id = 0
        for symbol in CardSymbol.allCases {
            for shading in CardShading.allCases {
                for number in 1..<4 {
                    for symbolColor in colors.indices {
                        let newCard = SetGame.Card(id: id, shading: shading, symbol: symbol, color: colors[symbolColor], numberOnCard: number)
                        deck.append(newCard)
                        id += 1
                    }
                }
            }
        }
        return deck
    }
    
    mutating func newGame() {
        var deck = SetGame.createCards()
        deck.shuffle()
        let cardsOnTable = Array(deck[0..<12])
        deck.removeAll { card in
            cardsOnTable.contains { $0 == card }
        }
        self.deck = deck
        self.cardsOnTable = cardsOnTable
    }
    
    
    
    struct Card: Identifiable, Equatable {
        var id: Int
        var shading: CardShading
        var symbol: CardSymbol
        var color: Color
        var isMatched: Bool = false
        var isSelected: Bool = false
        var numberOnCard: Int
    }
    
}
