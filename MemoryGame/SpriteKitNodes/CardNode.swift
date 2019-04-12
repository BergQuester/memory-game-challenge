//
//  CardNode.swift
//  MemoryGame
//
//  Created by Daniel Bergquist on 4/12/19.
//

import SpriteKit

class CardNode: SKSpriteNode {
    var cardIndex: IndexPath

    init(withState initialState: GameCard, andIndex cardIndex: IndexPath) {
        self.cardIndex = cardIndex

        let backTexture = initialState.backTexture()

        super.init(texture: backTexture, color: .clear, size: backTexture.size())
    }

    func update(withState newState: GameCard) {
        if newState.isFaceUp {
            self.texture = newState.faceTexture()
        } else {
            self.texture = newState.backTexture()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Coding is not currently supported")
    }
}


