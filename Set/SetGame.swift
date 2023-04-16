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
                let chosenCards = [chosenCard1, chosenCard2, chosenCard3]
                
                let color = all3EqualOrAllDifferent(chosenCard1.color, chosenCard2.color, chosenCard3.color)
                let shading = all3EqualOrAllDifferent(chosenCard1.shading, chosenCard2.shading, chosenCard3.shading)
                let symbol = all3EqualOrAllDifferent(chosenCard1.symbol, chosenCard2.symbol, chosenCard3.symbol)
                let numberOnCard = all3EqualOrAllDifferent(chosenCard1.numberOnCard, chosenCard2.numberOnCard, chosenCard3.numberOnCard)
                
                
                if color && shading && symbol && numberOnCard {
                    for chosenCard in chosenCards {
                        cards[cards.firstIndex(where: {chosenCard.id == $0.id})!].isMatched = true
                    }
                    score += 1
                    if (cardsOnTheTable < GameConstants.cardsOnTableInTheBeggining) {
                        addCardsToTable(GameConstants.numberOfCardsToDraw)
                    }
                } else {
                    score -= 1
                }
                for chosenCard in chosenCards {
                    cards[cards.firstIndex(where: {chosenCard.id == $0.id})!].isSelected = false
                }
            }
        }
    }
    
    func all3EqualOrAllDifferent<EquatableObject: Equatable>(_ first: EquatableObject, _ second: EquatableObject, _ third: EquatableObject) -> Bool {
        (first == second && first == third) || ((first != second && first != third) && second != third)
    }
    
    mutating func addCardsToTable(_ numberOfCards: Int) {
        var i = 0
        var cardsAdded = 0
        while cardsAdded < numberOfCards && i < cards.count {
            let card = cards[i]
            if (!card.isOnTheTable && !card.isMatched) {
                let cardIndexToBeModified = cards.firstIndex(where: {$0.id == card.id})
                if (cardIndexToBeModified != nil) {
                    cards[cardIndexToBeModified!].isOnTheTable = true
                    cardsAdded += 1
                }

            }
            i += 1
        }
    }
    
    var displayedCards: Array<Card> {
        cards.filter { card in
            card.isOnTheTable && !card.isMatched
        }
    }
    
    var cardsOnTheTable: Int {
        cards.filter({$0.isOnTheTable && !$0.isMatched}).count
    }
    
    init() {
        var deck = SetGame.createCards()
        deck.shuffle()
        for i in 0..<GameConstants.cardsOnTableInTheBeggining {
            deck[i].isOnTheTable = true
        }
        self.cards = deck
    }
    
    private static func createCards() -> Array<SetGame.Card> {
        let colors: Array<Color> = [.blue, .green, .red]
        var deck: Array<SetGame.Card> = Array()
        var id = 0
        for symbol in CardSymbol.allCases {
            for shading in CardShading.allCases {
                for number in 1..<GameConstants.numberOfDifferences {
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
    
    private struct GameConstants {
        static let numberOfDifferences = 4
        static let cardsOnTableInTheBeggining = 12
        static let numberOfCardsToDraw = 3
        
    }
    
}
