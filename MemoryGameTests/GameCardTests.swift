//
//  GameCardTests.swift
//  MemoryGameTests
//
//  Created by Daniel Bergquist on 4/11/19.
//

import XCTest
@testable import MemoryGame

class GameCardTests: XCTestCase {

    func testInitWithCardType() {
        let card = GameCard(withCardType: .dragon)

        XCTAssertEqual(card.cardType, .dragon)
        XCTAssertFalse(card.isFaceUp)
    }

    func testGenerateDeckForGameSize_generatesDeckOfExepectedSize() {
        XCTAssertEqual(GameCard.generateDeck(forGameSize: .threeByFour).count, GameSize.threeByFour.numberOfCards())
        XCTAssertEqual(GameCard.generateDeck(forGameSize: .fiveByTwo).count, GameSize.fiveByTwo.numberOfCards())
        XCTAssertEqual(GameCard.generateDeck(forGameSize: .fourByFour).count, GameSize.fourByFour.numberOfCards())
        XCTAssertEqual(GameCard.generateDeck(forGameSize: .fourByFive).count, GameSize.fourByFive.numberOfCards())
    }

    func testGenerateDeckForGameSize_generatesDeckOfPairs() {
        let cardTypes = GameCard.generateDeck(forGameSize: .threeByFour).map { $0.cardType }
        let deckSet = NSCountedSet(array: cardTypes)

        deckSet.forEach { XCTAssertEqual(deckSet.count(for: $0), 2) }
    }

    func testGenerateDeckForGameSize_generatesRandomDecks() {

        // FIXME: This should really use a known seed to avoid
        // randomly generating the same set of pairs. This is good enough
        // for demonstration purposes
        let cardTypes1 = GameCard.generateDeck(forGameSize: .threeByFour).map { $0.cardType }
        let cardTypes2 = GameCard.generateDeck(forGameSize: .threeByFour).map { $0.cardType }

        let set1 = Set(cardTypes1)
        let set2 = Set(cardTypes2)

        XCTAssertNotEqual(set1, set2)
    }
}
