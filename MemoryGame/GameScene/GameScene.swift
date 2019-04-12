//
//  GameScene.swift
//  MemoryGame
//
//  Created by Daniel Bergquist on 4/11/19.
//

import SpriteKit
import GameplayKit

protocol GameSceneDelegate {
    func gameScene(_ gameScene: GameScene, didMoveToView view: SKView)
    func gameScene(_ gameScene: GameScene, didTapCard card: CardNode)
}

class GameScene: SKScene {

    var gameDelegate: GameSceneDelegate?
    
    override func didMove(to view: SKView) {

        self.gameDelegate?.gameScene(self, didMoveToView: view)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {

        // Figure out if any of the touches tapped a card
        // and notify the gameDelegate
        touches
            .map { $0.location(in: self) }
            .compactMap { self.atPoint($0) as? CardNode }
            .forEach { self.gameDelegate?.gameScene(self, didTapCard: $0) }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
