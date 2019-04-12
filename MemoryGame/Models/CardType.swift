//
//  CardType.swift
//  MemoryGame
//
//  Created by Daniel Bergquist on 4/11/19.
//

import Foundation
import SpriteKit

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

//Mark: - Graphics access
extension CardType {
    static func faceTexture(forCardType cardType: CardType) -> SKTexture {
        switch cardType {
        case .bat:
            return SKTexture(imageNamed: "memoryBatCardFront")
        case .cat:
            return SKTexture(imageNamed: "memoryCatCardFront")
        case .cow:
            return SKTexture(imageNamed: "memoryCowCardFront")
        case .dragon:
            return SKTexture(imageNamed: "memoryDragonCardFront")
        case .garbageMan:
            return SKTexture(imageNamed: "memoryGarbageManCardFront")
        case .ghostDog:
            return SKTexture(imageNamed: "memoryGhostDogCardFront")
        case .hen:
            return SKTexture(imageNamed: "memoryHenCardFront")
        case .horse:
            return SKTexture(imageNamed: "memoryHorseCardFront")
        case .pig:
            return SKTexture(imageNamed: "memoryPigCardFront")
        case .spider:
            return SKTexture(imageNamed: "memorySpiderCardFront")
        }
    }

    func faceTexture() -> SKTexture {
        return CardType.faceTexture(forCardType: self)
    }
}
