//
//  GameSizeTests.swift
//  MemoryGameTests
//
//  Created by Daniel Bergquist on 4/11/19.
//

import XCTest
@testable import MemoryGame

class GameSizeTests: XCTestCase {

    func testNumberOfColumns() {

        XCTAssertEqual(GameSize.threeByFour.numberOfColumns(), 3)
        XCTAssertEqual(GameSize.fiveByTwo.numberOfColumns(), 5)
        XCTAssertEqual(GameSize.fourByFour.numberOfColumns(), 4)
        XCTAssertEqual(GameSize.fourByFive.numberOfColumns(), 4)
    }

    func testNumberOfRows() {

        XCTAssertEqual(GameSize.threeByFour.numberOfRows(), 4)
        XCTAssertEqual(GameSize.fiveByTwo.numberOfRows(), 2)
        XCTAssertEqual(GameSize.fourByFour.numberOfRows(), 4)
        XCTAssertEqual(GameSize.fourByFive.numberOfRows(), 5)
    }

    func testNumberOfCards() {

        XCTAssertEqual(GameSize.threeByFour.numberOfCards(),
                       GameSize.threeByFour.numberOfColumns() * GameSize.threeByFour.numberOfRows())
        XCTAssertEqual(GameSize.fiveByTwo.numberOfCards(),
                       GameSize.fiveByTwo.numberOfColumns() * GameSize.fiveByTwo.numberOfRows())
        XCTAssertEqual(GameSize.fourByFour.numberOfCards(),
                       GameSize.fourByFour.numberOfColumns() * GameSize.fourByFour.numberOfRows())
        XCTAssertEqual(GameSize.fourByFive.numberOfCards(),
                       GameSize.fourByFive.numberOfColumns() * GameSize.fourByFive.numberOfRows())
    }
}
