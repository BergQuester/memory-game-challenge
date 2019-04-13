//
//  AudioPlayer.swift
//  MemoryGame
//
//  Created by Daniel Bergquist on 4/13/19.
//

import Foundation
import AVFoundation

class AudioPlayer {

    static let shared = AudioPlayer()

    var audioPLayer: AVAudioPlayer?

    init() {

        do {
            try AVAudioSession.sharedInstance().setCategory(.ambient)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch let error {
            print(error.localizedDescription)
        }
    }

    func play(soundNamed soundName: String) {

        guard let soundURL = Bundle.main.url(forResource: soundName, withExtension: "m4a") else {
            return
        }

        do {
            self.audioPLayer = try AVAudioPlayer(contentsOf: soundURL)
            self.audioPLayer?.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
