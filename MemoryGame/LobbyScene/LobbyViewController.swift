//
//  LobbyViewController.swift
//  MemoryGame
//
//  Created by Daniel Bergquist on 4/11/19.
//

import UIKit

class LobbyViewController: UIViewController {

    enum Segues: String {
        case lobbyToGameSegue
    }

    @IBAction func startGame(_ sender: UIButton) {
        self.performSegue(withIdentifier: Segues.lobbyToGameSegue.rawValue, sender: sender)
    }
}

//MARK: - Lifecycle methods
extension LobbyViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
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
