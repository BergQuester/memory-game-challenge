//
//  CardTypeTests.swift
//  MemoryGameTests
//
//  Created by Daniel Bergquist on 4/11/19.
//

import XCTest
@testable import MemoryGame

class CardTypeTests: XCTestCase {

    func testgeneratePairs_generatesGivenNumberOfPairs() {
        XCTAssertEqual(CardType.generatePairs(numberOfPairs: 1).count, 1)
        XCTAssertEqual(CardType.generatePairs(numberOfPairs: 6).count, 6)
        XCTAssertEqual(CardType.generatePairs(numberOfPairs: 5).count, 5)
        XCTAssertEqual(CardType.generatePairs(numberOfPairs: 8).count, 8)
        XCTAssertEqual(CardType.generatePairs(numberOfPairs: 10).count, 10)
    }

    func testgeneratePairs_generatesRandomSets() {

        // FIXME: This should really use a known seed to avoid
        // randomly generating the same set of pairs. This is good enough
        // for demonstration purposes
        let set1 = Set(CardType.generatePairs(numberOfPairs: 6))
        let set2 = Set(CardType.generatePairs(numberOfPairs: 6))

        XCTAssertNotEqual(set1, set2)
    }
}
