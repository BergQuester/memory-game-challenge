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
}

//MARK: - ViewController lifecycle
extension GameViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
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

//MARK: - Roatation management methods
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

