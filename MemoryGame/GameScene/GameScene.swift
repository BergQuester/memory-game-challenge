//
//  GameScene.swift
//  MemoryGame
//
//  Created by Daniel Bergquist on 4/11/19.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    override func didMove(to view: SKView) {
        
        let card = CardNode(withState: GameCard(withCardType: .bat))
        card.position = CGPoint(x: 50, y: 100)
        self.addChild(card)
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
