//
//  GameStateTests.swift
//  MemoryGameTests
//
//  Created by Daniel Bergquist on 4/11/19.
//

import XCTest
@testable import MemoryGame

class GameStateTests: XCTestCase {

    func testInitWithGameSize() {
        let gameSize = GameSize.fourByFour
        let gameState = GameState(gameSize: gameSize)

        XCTAssertEqual(gameState.gameSize, gameSize)
        XCTAssertEqual(gameState.deck.count, gameSize.numberOfCards())
        XCTAssertTrue(gameState.matchedCardTypes.isEmpty)
    }

    func testCardForIndexPath() {
        let state = GameState(gameSize: .fourByFive)

        let card1 = state.deck.first
        let foundCard1 = state.card(forIndexPath: IndexPath(row: 0, section: 0))

        XCTAssertNotNil(foundCard1)
        XCTAssertEqual(foundCard1, card1)

        let card2 = state.deck[12]
        let foundCard2 = state.card(forIndexPath: IndexPath(row: 2, section: 2))

        XCTAssertNotNil(foundCard2)
        XCTAssertEqual(foundCard2, card2)

        let card3 = state.deck[19]
        let foundCard3 = state.card(forIndexPath: IndexPath(row: 4, section: 3))

        XCTAssertNotNil(foundCard3)
        XCTAssertEqual(foundCard3, card3)

        let foundCard4 = state.card(forIndexPath: IndexPath(row: 0, section: 4))

        XCTAssertNil(foundCard4)
    }

    func testUpdateCardAtIndex() {
        var state = GameState(gameSize: .fourByFive)

        var card1 = state.deck[0]
        let indexPath1 = IndexPath(row: 0, section: 0)
        card1.isFaceUp = true
        state.update(card: card1, atIndex: indexPath1)

        let foundCard1 = state.card(forIndexPath: IndexPath(row: 0, section: 0))

        XCTAssertNotNil(foundCard1)
        XCTAssertEqual(foundCard1, card1)

        var card2 = state.deck[12]
        let indexPath2 = IndexPath(row: 2, section: 2)
        card2.isFaceUp = true
        state.update(card: card2, atIndex: indexPath2)

        let foundCard2 = state.card(forIndexPath: IndexPath(row: 2, section: 2))

        XCTAssertNotNil(foundCard2)
        XCTAssertEqual(foundCard2, card2)

        var card3 = state.deck[19]
        let indexPath3 = IndexPath(row: 4, section: 3)
        card3.isFaceUp = true
        state.update(card: card3, atIndex: indexPath3)

        let foundCard3 = state.card(forIndexPath: IndexPath(row: 4, section: 3))

        XCTAssertNotNil(foundCard3)
        XCTAssertEqual(foundCard3, card3)

        XCTAssertNoThrow(state.update(card: card3, atIndex: IndexPath(row: 5000000, section: 5000000)))
    }
}
