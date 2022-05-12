//
//  AudioPlayer.swift
//  Pinball
//
//  Created by 1 on 20.04.2022.
//

import AVFoundation

class AudioPlayer {
    
    static let shared = AudioPlayer()
    
    var audioPlayer: AVAudioPlayer?
    var isPlaingMusic = false
    
    func setupMusic() {
        let music = Bundle.main.path(forResource: ThemeManager.shared.currentTheme.gameSoundName, ofType: "wav")
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: music!))
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.ambient)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print(error)
        }
    }
    
    func playMusic() {
        audioPlayer?.numberOfLoops = -1
        audioPlayer?.play()
        isPlaingMusic = true
    }
    
    func stopMusic() {
        audioPlayer?.stop()
        isPlaingMusic = false
    }
    
    func changeVolume(volume: Float) {
        audioPlayer?.volume = volume
    }
}

