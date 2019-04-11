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
}
