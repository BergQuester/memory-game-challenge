//
//  GameState.swift
//  MemoryGame
//
//  Created by Daniel Bergquist on 4/11/19.
//

import Foundation

struct GameState {
    let gameSize: GameSize
    var deck: [GameCard]
    var matchedCardTypes: [CardType] = []
}

//MARK: - Convienence initializers
extension GameState {
    init(gameSize: GameSize) {
        self.gameSize = gameSize
        self.deck = GameCard.generateDeck(forGameSize: gameSize)
    }
}

//MARK: - Card accessors
extension GameState {
    func card(forIndexPath index: IndexPath) -> GameCard? {
        let cardIndex = self.arrayIndex(forCardIndexPath: index)

        guard cardIndex <= self.deck.count else {
            return nil
        }
        
        return self.deck[cardIndex]
    }

    mutating func update(card: GameCard, atIndex index: IndexPath) {
        let cardIndex = self.arrayIndex(forCardIndexPath: index)

        guard cardIndex <= self.deck.count else {
            return
        }

        self.deck[cardIndex] = card
    }

    func cardIndexPath(forArrayIndex arrayIndex: Int) -> IndexPath {
        return self.gameSize.cardIndexPath(forArrayIndex: arrayIndex)
    }

    private func arrayIndex(forCardIndexPath index: IndexPath) -> Int {
        return self.gameSize.arrayIndex(forCardIndexPath: index)
    }
}
