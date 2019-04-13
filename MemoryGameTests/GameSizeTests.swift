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

    func testCardIndexPathForArrayIndex() {
        var index = 0

        XCTAssertEqual(GameSize.threeByFour.cardIndexPath(forArrayIndex: index), IndexPath(row: 0, section: 0))
        XCTAssertEqual(GameSize.fiveByTwo.cardIndexPath(forArrayIndex: index), IndexPath(row: 0, section: 0))
        XCTAssertEqual(GameSize.fourByFour.cardIndexPath(forArrayIndex: index), IndexPath(row: 0, section: 0))
        XCTAssertEqual(GameSize.fourByFive.cardIndexPath(forArrayIndex: index), IndexPath(row: 0, section: 0))

        index = 1

        XCTAssertEqual(GameSize.threeByFour.cardIndexPath(forArrayIndex: index), IndexPath(row: 1, section: 0))
        XCTAssertEqual(GameSize.fiveByTwo.cardIndexPath(forArrayIndex: index), IndexPath(row: 1, section: 0))
        XCTAssertEqual(GameSize.fourByFour.cardIndexPath(forArrayIndex: index), IndexPath(row: 1, section: 0))
        XCTAssertEqual(GameSize.fourByFive.cardIndexPath(forArrayIndex: index), IndexPath(row: 1, section: 0))

        index = 2

        XCTAssertEqual(GameSize.threeByFour.cardIndexPath(forArrayIndex: index), IndexPath(row: 2, section: 0))
        XCTAssertEqual(GameSize.fiveByTwo.cardIndexPath(forArrayIndex: index), IndexPath(row: 0, section: 1))
        XCTAssertEqual(GameSize.fourByFour.cardIndexPath(forArrayIndex: index), IndexPath(row: 2, section: 0))
        XCTAssertEqual(GameSize.fourByFive.cardIndexPath(forArrayIndex: index), IndexPath(row: 2, section: 0))

        index = 7

        XCTAssertEqual(GameSize.threeByFour.cardIndexPath(forArrayIndex: index), IndexPath(row: 3, section: 1))
        XCTAssertEqual(GameSize.fiveByTwo.cardIndexPath(forArrayIndex: index), IndexPath(row: 1, section: 3))
        XCTAssertEqual(GameSize.fourByFour.cardIndexPath(forArrayIndex: index), IndexPath(row: 3, section: 1))
        XCTAssertEqual(GameSize.fourByFive.cardIndexPath(forArrayIndex: index), IndexPath(row: 2, section: 1))

        index = 9   // Largest index that all games sizes can take

        XCTAssertEqual(GameSize.threeByFour.cardIndexPath(forArrayIndex: index), IndexPath(row: 1, section: 2))
        XCTAssertEqual(GameSize.fiveByTwo.cardIndexPath(forArrayIndex: index), IndexPath(row: 1, section: 4))
        XCTAssertEqual(GameSize.fourByFour.cardIndexPath(forArrayIndex: index), IndexPath(row: 1, section: 2))
        XCTAssertEqual(GameSize.fourByFive.cardIndexPath(forArrayIndex: index), IndexPath(row: 4, section: 1))

        index = 11 // Largest index the three biggest game sizes can all take

        XCTAssertEqual(GameSize.threeByFour.cardIndexPath(forArrayIndex: index), IndexPath(row: 3, section: 2))
        XCTAssertEqual(GameSize.fourByFour.cardIndexPath(forArrayIndex: index), IndexPath(row: 3, section: 2))
        XCTAssertEqual(GameSize.fourByFive.cardIndexPath(forArrayIndex: index), IndexPath(row: 1, section: 2))

        index = 15 // Largest index the two biggest game sizes can all take

        XCTAssertEqual(GameSize.fourByFour.cardIndexPath(forArrayIndex: index), IndexPath(row: 3, section: 3))
        XCTAssertEqual(GameSize.fourByFive.cardIndexPath(forArrayIndex: index), IndexPath(row: 0, section: 3))

        index = 19 // Largest index the  biggest game size can take

        XCTAssertEqual(GameSize.fourByFive.cardIndexPath(forArrayIndex: index), IndexPath(row: 4, section: 3))
    }

    func testArrayIndexForCardIndexPath() {
        var index = IndexPath(row: 0, section: 0)

        XCTAssertEqual(GameSize.threeByFour.arrayIndex(forCardIndexPath: index), 0)
        XCTAssertEqual(GameSize.fiveByTwo.arrayIndex(forCardIndexPath: index), 0)
        XCTAssertEqual(GameSize.fourByFour.arrayIndex(forCardIndexPath: index), 0)
        XCTAssertEqual(GameSize.fourByFive.arrayIndex(forCardIndexPath: index), 0)

        index = IndexPath(row: 1, section: 0)

        XCTAssertEqual(GameSize.threeByFour.arrayIndex(forCardIndexPath: index), 1)
        XCTAssertEqual(GameSize.fiveByTwo.arrayIndex(forCardIndexPath: index), 1)
        XCTAssertEqual(GameSize.fourByFour.arrayIndex(forCardIndexPath: index), 1)
        XCTAssertEqual(GameSize.fourByFive.arrayIndex(forCardIndexPath: index), 1)

        index = IndexPath(row: 2, section: 0)

        XCTAssertEqual(GameSize.threeByFour.arrayIndex(forCardIndexPath: index), 2)
        XCTAssertEqual(GameSize.fiveByTwo.arrayIndex(forCardIndexPath: index), 2)
        XCTAssertEqual(GameSize.fourByFour.arrayIndex(forCardIndexPath: index), 2)
        XCTAssertEqual(GameSize.fourByFive.arrayIndex(forCardIndexPath: index), 2)

        index = IndexPath(row: 3, section: 1)

        XCTAssertEqual(GameSize.threeByFour.arrayIndex(forCardIndexPath: index), 7)
        XCTAssertEqual(GameSize.fourByFour.arrayIndex(forCardIndexPath: index), 7)
        XCTAssertEqual(GameSize.fourByFive.arrayIndex(forCardIndexPath: index), 8)

        index = IndexPath(row: 1, section: 4)

        XCTAssertEqual(GameSize.fiveByTwo.arrayIndex(forCardIndexPath: index), 9)

        index = IndexPath(row: 3, section: 2)

        XCTAssertEqual(GameSize.threeByFour.arrayIndex(forCardIndexPath: index), 11)
        XCTAssertEqual(GameSize.fourByFour.arrayIndex(forCardIndexPath: index), 11)
        XCTAssertEqual(GameSize.fourByFive.arrayIndex(forCardIndexPath: index), 13)

        index = IndexPath(row: 3, section: 3)

        XCTAssertEqual(GameSize.fourByFour.arrayIndex(forCardIndexPath: index), 15)
        XCTAssertEqual(GameSize.fourByFive.arrayIndex(forCardIndexPath: index), 18)

        index = IndexPath(row: 4, section: 3)

        XCTAssertEqual(GameSize.fourByFive.arrayIndex(forCardIndexPath: index), 19)
    }
}
