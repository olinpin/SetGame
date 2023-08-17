//
//  SetGameModelView.swift
//  Set
//
//  Created by Oliver Hnát on 10.04.2023.
//

import Foundation
import SwiftUI


class SetGameModelView: ObservableObject {
    
    typealias Card = SetGame.Card
    
    @Published private var model: SetGame
    
    init() {
        self.model = SetGame()
    }
    
    var cardsOnTable: Array<Card> {
        model.displayedCards.filter(showCard)
    }

    private func showCard(card: SetGameModelView.Card) -> Bool {
        !card.isMatched
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
    
    var colors: [Int : Color] {
        self.model.colors
    }
    
    
}
