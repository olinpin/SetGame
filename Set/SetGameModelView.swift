//
//  SetGameModelView.swift
//  Set
//
//  Created by Oliver Hnát on 10.04.2023.
//

import Foundation


class SetGameModelView: ObservableObject {
    
    typealias Card = SetGame.Card
    
    @Published private var model: SetGame
    
    init() {
        self.model = SetGame()
    }
    
    var cardsOnTable: Array<Card> {
//        var cardsOnTable: Array<Card> = Array()
//        for card in model.cards {
//            if (card.isOnTheTable && !card.isMatched) {
//                cardsOnTable.append(card)
//            }
//        }
//        return cardsOnTable
        model.displayedCards
    }
    
    func newGame() {
        self.model = SetGame()
    }
    
    func choose(_ card: Card) {
        self.model.choose(card)
    }
    
    var score: Int {
        model.score
    }
    
    func deal() {
        self.model.addCardsToTable(3)
    }
    
    
}
