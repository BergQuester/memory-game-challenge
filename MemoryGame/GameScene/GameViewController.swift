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

    override func viewDidAppear(_ animated: Bool) {
        AudioPlayer.shared.play(soundNamed: "gameInstructions")
    }
}

//MARK: - Game logic
extension GameViewController: GameSceneDelegate {

    func gameScene(_ gameScene: GameScene, didMoveToView view: SKView) {
        guard let gameState = self.gameState else {
            return
        }

        // Create the card nodes that will display in the playfield
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

        self.playField.scene?.size = self.view.frame.size
        self.playField.layout()
    }

    func gameScene(_ gameScene: GameScene, didTapCard card: CardNode) {
        guard var cardModel = self.gameState?.card(forIndexPath: card.cardIndex),
            let gameState = self.gameState,
            cardModel.isFaceUp == false else {
            return
        }

        print("tapped cardModel: \(cardModel)")

        // Show the face of the tapped card
        cardModel.isFaceUp.toggle()
        self.gameState?.update(card: cardModel, atIndex: card.cardIndex)
        card.update(withState: cardModel)

        // check if the selected card matches the previous selection
        if let attemptedPairIndex = gameState.attemptedPairIndex,
            let attemptedPair = gameState.card(forIndexPath: attemptedPairIndex) {

            // If matched, add to matched card types
            // Otherwise, reset the unmatched cards in the deck
            if attemptedPair.cardType == cardModel.cardType {
                self.gameState?.matchedCardTypes.append(cardModel.cardType)
                AudioPlayer.shared.play(soundNamed: "matchFound")
            } else {

                if let gameState = self.gameState {
                    let newState = self.resetUnmatchedCards(withGameState: gameState)
                    self.gameState = newState
                    self.playField.prepareResetActions(withGameState: newState)
                }
            }

            self.gameState?.attemptedPairIndex = nil
        } else {
            self.gameState?.attemptedPairIndex = card.cardIndex
        }
    }

    private func resetUnmatchedCards(withGameState gameState: GameState) -> GameState {

        var newState = gameState
        newState.deck = self.resetUnmatchedCards(inDeck: gameState.deck, andMatches: gameState.matchedCardTypes)

        return newState
    }

    private func resetUnmatchedCards(inDeck deck: [GameCard], andMatches matches: [CardType]) -> [GameCard] {

        let resetDeck: [GameCard] = deck
            .map { card in
                guard !matches.contains(card.cardType) else {
                    return card
                }

                var newCard = card
                newCard.isFaceUp = false
                return newCard
        }

        return resetDeck
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

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { [weak self] _ in
            guard let strongSelf = self else {
                return
            }

            strongSelf.playField.scene?.size = size
            strongSelf.playField.layout()
        })
    }
}

