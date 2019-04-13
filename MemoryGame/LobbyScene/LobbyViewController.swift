//
//  LobbyViewController.swift
//  MemoryGame
//
//  Created by Daniel Bergquist on 4/11/19.
//

import UIKit

protocol Game {
    var gameSize: GameSize? { get set }
}

class LobbyViewController: UIViewController {

    enum Segues: String {
        case lobbyToGameSegue
    }

    @IBAction func startGame(_ sender: UIButton) {
        self.performSegue(withIdentifier: Segues.lobbyToGameSegue.rawValue, sender: sender)
    }
}

//MARK: - View lifecycle
extension LobbyViewController {
    override func viewDidAppear(_ animated: Bool) {
        AudioPlayer.shared.play(soundNamed: "lobbyInstructions")
    }
}

//MARK: - Segue management
extension LobbyViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == Segues.lobbyToGameSegue.rawValue {
            // make sure we can get all the right info
            if let sizeSelection = (sender as? UIView)?.tag,
                let gameMode = GameSize(rawValue: sizeSelection),
                var destination = segue.destination as? Game {

                destination.gameSize = gameMode
            }
        }

        super.prepare(for: segue, sender: sender)
    }

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == Segues.lobbyToGameSegue.rawValue {
            if let sizeSelection = (sender as? UIView)?.tag,
                GameSize(rawValue: sizeSelection) != nil {
                return true
            }

            let alert = UIAlertController(title: "Opps", message: "Something went wrong", preferredStyle: .alert)
            self.present(alert, animated: true)

            return false
        }

        return super.shouldPerformSegue(withIdentifier: identifier, sender: sender)
    }

    @IBAction func unwindToLobby(segue: UIStoryboardSegue) { }
}

//MARK: - Roatation management methods
extension LobbyViewController {
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
