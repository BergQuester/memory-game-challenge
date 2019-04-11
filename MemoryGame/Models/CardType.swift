//
//  CardType.swift
//  MemoryGame
//
//  Created by Daniel Bergquist on 4/11/19.
//

import Foundation

enum CardType: CaseIterable {
    case bat
    case cat
    case cow
    case dragon
    case garbageMan
    case ghostDog
    case hen
    case horse
    case pig
    case spider
}

//MARK: - Deck generation
extension CardType {
    static func generatePairs(numberOfPairs pairCount: Int) -> [CardType] {
        // FIXME: bubble up bad request error
        guard pairCount <= self.allCases.count else {
            return []
        }
        
        // shuffle all cases, return the required number of types
        return Array(self.allCases.shuffled()[..<pairCount])
    }
}
