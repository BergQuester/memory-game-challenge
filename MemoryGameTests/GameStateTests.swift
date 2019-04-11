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
}
