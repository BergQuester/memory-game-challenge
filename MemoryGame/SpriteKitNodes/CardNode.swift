//
//  CardNode.swift
//  MemoryGame
//
//  Created by Daniel Bergquist on 4/12/19.
//

import SpriteKit

class CardNode: SKSpriteNode {
    var state: GameCard

    init(withState initialState: GameCard) {
        self.state = initialState

        let backTexture = initialState.backTexture()

        super.init(texture: backTexture, color: .clear, size: backTexture.size())
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Coding is not currently supported")
    }
}


