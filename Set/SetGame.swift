//
//  SetGame.swift
//  Set
//
//  Created by Oliver Hnát on 09.04.2023.
//

import Foundation
import SwiftUI

struct SetGame {
    private(set) var cards: Array<Card>
    private(set) var score: Int = 0
    
    
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: {card.id == $0.id}),
           !cards[chosenIndex].isMatched,
           !cards[chosenIndex].isSelected,
           cards[chosenIndex].isOnTheTable
        {
            cards[chosenIndex].isSelected = true
            var chosenCards: Array<Card> = Array()
            for c in cards {
                if c.isSelected {
                    chosenCards.append(c)
                }
            }
            
            if chosenCards.count > 2 {
                let chosenCard1 = chosenCards[0]
                let chosenCard2 = chosenCards[1]
                let chosenCard3 = chosenCards[2]
                
                let color = all3EqualOrAllDifferent(chosenCard1.color, chosenCard2.color, chosenCard3.color)
                let shading = all3EqualOrAllDifferent(chosenCard1.shading, chosenCard2.shading, chosenCard3.shading)
                let symbol = all3EqualOrAllDifferent(chosenCard1.symbol, chosenCard2.symbol, chosenCard3.symbol)
                let numberOnCard = all3EqualOrAllDifferent(chosenCard1.numberOnCard, chosenCard2.numberOnCard, chosenCard3.numberOnCard)
                
                
                if color && shading && symbol && numberOnCard {
                    cards[cards.firstIndex(where: {chosenCard1.id == $0.id})!].isMatched = true
                    cards[cards.firstIndex(where: {chosenCard2.id == $0.id})!].isMatched = true
                    cards[cards.firstIndex(where: {chosenCard3.id == $0.id})!].isMatched = true
                    score += 1
                    if (cardsOnTheTable() < 12) {
                        addCardsToTable(3)
                    }
                } else {
                    score -= 1
                }
                cards[cards.firstIndex(where: {chosenCard1.id == $0.id})!].isSelected = false
                cards[cards.firstIndex(where: {chosenCard2.id == $0.id})!].isSelected = false
                cards[cards.firstIndex(where: {chosenCard3.id == $0.id})!].isSelected = false
                
                
            }
        }
    }
    
    func all3EqualOrAllDifferent<EquatableObject: Equatable>(_ first: EquatableObject, _ second: EquatableObject, _ third: EquatableObject) -> Bool {
        (first == second && first == third) || ((first != second && first != third) && second != third)
    }
    
    mutating func addCardsToTable(_ numberOfCards: Int) {
        print(cards.count, cardsOnTheTable())
        let maxCards = cardsOnTheTable() + 3
        var i = 0
        while cardsOnTheTable() < maxCards && i < 81 {
            let card = cards[i]
            if (!card.isOnTheTable && !card.isMatched) {
                cards[card.id].isOnTheTable = true
            }
            i += 1
        }
    }
    
    func cardsOnTheTable() -> Int {
        var cardsOnTable = 0
        for card in cards {
            if (card.isOnTheTable && !card.isMatched) {
                cardsOnTable += 1
            }
        }
        return cardsOnTable
    }
    

    
    init() {
        var deck = SetGame.createCards()
        deck.shuffle()
        for i in 0..<12 {
            deck[i].isOnTheTable = true
        }
        self.cards = deck
        print(cards.count)
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



    
    
    
    
    
    struct Card: Identifiable, Equatable {
        var id: Int
        var shading: CardShading
        var symbol: CardSymbol
        var color: Color
        var isMatched: Bool = false
        var isSelected: Bool = false
        var isOnTheTable: Bool = false
        var numberOnCard: Int
    }
    
}
