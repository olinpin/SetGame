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
        model.cardsOnTable
    }
    
    func newGame() {
        self.model = SetGame()
    }
    
    
}
