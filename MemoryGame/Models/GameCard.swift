//
//  GameCard.swift
//  MemoryGame
//
//  Created by Daniel Bergquist on 4/11/19.
//

import Foundation
import SpriteKit

struct GameCard {
    let cardType: CardType  // What card this is
    var isFaceUp = false    // Are we currently showing our face?
}

//MARK: - Convienence initializers
extension GameCard {
    init(withCardType cardType: CardType) {
        self.cardType = cardType
    }
}

//MARK: - Deck generation
extension GameCard {

    static func generateDeck(forGameSize gameSize: GameSize) -> [GameCard] {
        return generateDeck(ofSize: gameSize.numberOfCards())
    }

    private static func generateDeck(ofSize deckSize: Int) -> [GameCard] {
        // get random pairs, generate and shuffle deck from pairs
        let numberOfPairs = deckSize / 2
        let cardPairs = CardType.generatePairs(numberOfPairs: numberOfPairs)
        let deck = generateCards(fromPairs: cardPairs).shuffled()

        return deck
    }

    private static func generateCards(fromPairs pairs: [CardType]) -> [GameCard] {
        let cards = pairs.map(self.init(withCardType:))
        // duplicate the cards so we have pairs
        return cards + cards
    }
}


//Mark: - Graphics access
extension GameCard {
    static func backTexture() -> SKTexture {
        return SKTexture(imageNamed: "allCardBacks")
    }

    func backTexture() -> SKTexture {
        return GameCard.backTexture()
    }

    func faceTexture() -> SKTexture {
        return self.cardType.faceTexture()
    }
}
