//
//  GameViewController.swift
//  MemoryGame
//
//  Created by Daniel Bergquist on 4/11/19.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController, Game {

    var gameState: GameState?
    var gameSize: GameSize? {
        set {
            guard let newSize = newValue else {
                self.gameState = nil
                return
            }
            self.gameState = GameState(gameSize: newSize)
        }
        get {
            return self.gameState?.gameSize
        }
    }

    let playField = PlayFieldNode()
}

//MARK: - ViewController lifecycle
extension GameViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") as? GameScene {

                scene.gameDelegate = self

                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill

                // Present the scene
                view.presentScene(scene)
            }

            view.ignoresSiblingOrder = true

            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
}

//MARK: - Game logic
extension GameViewController: GameSceneDelegate {

    func gameScene(_ gameScene: GameScene, didMoveToView view: SKView) {
        guard let gameState = self.gameState else {
            return
        }

        var cardNodes: [CardNode] = []
        self.playField.gameSize = self.gameState?.gameSize

        for (index, card) in gameState.deck.enumerated() {
            let indexPath = gameState.cardIndexPath(forArrayIndex: index)
            let cardNode = CardNode(withState: card, andIndex: indexPath)

            cardNodes.append(cardNode)

            self.playField.addCard(cardNode)
        }

        self.playField.position = CGPoint(x: 0, y: -35)
        gameScene.addChild(self.playField)
        self.playField.layout()
    }

    func gameScene(_ gameScene: GameScene, didTapCard card: CardNode) {
        guard var cardModel = self.gameState?.card(forIndexPath: card.cardIndex),
            let gameState = self.gameState,
            cardModel.isFaceUp == false else {
            return
        }

        cardModel.isFaceUp.toggle()
        self.gameState?.update(card: cardModel, atIndex: card.cardIndex)
        card.update(withState: cardModel)

        if let attemptedPairIndex = gameState.attemptedPairIndex,
            var attemptedPair = gameState.card(forIndexPath: attemptedPairIndex) {

            if attemptedPair.cardType == cardModel.cardType {
                self.gameState?.matchedCardTypes.append(cardModel.cardType)
            } else {
                let waitAction = SKAction.wait(forDuration: 1.0)
                let flipAction = SKAction.run { [weak self] in
                    guard let strongSelf = self,
                        let gameState = strongSelf.gameState else {
                        return
                    }

                    strongSelf.playField.cards.forEach { card in
                        guard var cardModel = gameState.card(forIndexPath: card.cardIndex) else {
                            return
                        }

                        if cardModel.isFaceUp && !gameState.matchedCardTypes.contains(cardModel.cardType) {
                            cardModel.isFaceUp.toggle()
                            strongSelf.gameState?.update(card: cardModel, atIndex: card.cardIndex)
                            card.update(withState: cardModel)
                        }
                    }
                }

                self.playField.run(SKAction.sequence([waitAction, flipAction]))
            }

            self.gameState?.attemptedPairIndex = nil
        } else {
            self.gameState?.attemptedPairIndex = card.cardIndex
        }
    }
}

//MARK: - Rotation management methods
extension GameViewController {
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}

