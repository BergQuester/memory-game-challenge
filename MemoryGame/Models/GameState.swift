//
//  GameState.swift
//  MemoryGame
//
//  Created by Daniel Bergquist on 4/11/19.
//

import Foundation

struct GameState {
    let gameSize: GameSize
    let deck: [GameCard]
    var matchedCardTypes: [CardType] = []
}

//MARK: - Convienence initializers
extension GameState {
    init(gameSize: GameSize) {
        self.gameSize = gameSize
        self.deck = GameCard.generateDeck(forGameSize: gameSize)
    }
}
