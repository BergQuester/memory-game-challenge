//
//  CardNode.swift
//  MemoryGame
//
//  Created by Daniel Bergquist on 4/12/19.
//

import SpriteKit

class CardNode: SKSpriteNode {

    static let flipAnimationDuration = TimeInterval(0.6)

    var cardIndex: IndexPath
    var lastFaceUpState = false

    init(withState initialState: GameCard, andIndex cardIndex: IndexPath) {
        self.cardIndex = cardIndex

        let backTexture = initialState.backTexture()

        super.init(texture: backTexture, color: .clear, size: backTexture.size())
    }

    func update(withState newState: GameCard) {

        guard newState.isFaceUp != self.lastFaceUpState else {
            return
        }

        let texture = newState.isFaceUp ? newState.faceTexture() : newState.backTexture()

        let animationDuration = CardNode.flipAnimationDuration / 2.0
        let flipPart1 = SKAction.scale(to: 1.3, duration: animationDuration)
        let flipPart2 = SKAction.scale(to: 1.0, duration: animationDuration)

        self.zPosition = 10.0
        
        self.run(flipPart1) {
            self.texture = texture
            self.run(flipPart2) {
                self.zPosition = 0.0
            }
        }

        self.lastFaceUpState = newState.isFaceUp
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Coding is not currently supported")
    }
}


