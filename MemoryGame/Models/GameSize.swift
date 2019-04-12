//
//  GameSize.swift
//  MemoryGame
//
//  Created by Daniel Bergquist on 4/11/19.
//

import Foundation

enum GameSize: Int, CaseIterable {
    case threeByFour
    case fiveByTwo
    case fourByFour
    case fourByFive
}

//MARK: - Convenience methods
extension GameSize {
    func numberOfColumns() -> Int {
        switch self {
        case .threeByFour:
            return 3
        case .fiveByTwo:
            return 5
        case .fourByFour:
            return 4
        case .fourByFive:
            return 4
        }
    }

    func numberOfRows() -> Int {
        switch self {
        case .threeByFour:
            return 4
        case .fiveByTwo:
            return 2
        case .fourByFour:
            return 4
        case .fourByFive:
            return 5
        }
    }

    func numberOfCards() -> Int {
        return self.numberOfColumns() * self.numberOfRows()
    }

    func cardIndexPath(forArrayIndex arrayIndex: Int) -> IndexPath {
        let column = arrayIndex / self.numberOfRows()
        let row = arrayIndex % self.numberOfRows()

        return IndexPath(row: row, section: column)
    }

    func arrayIndex(forCardIndexPath index: IndexPath) -> Int {
        let columnOffset = index.section * self.numberOfRows()
        let cardIndex = columnOffset + index.row
        return cardIndex
    }
}
