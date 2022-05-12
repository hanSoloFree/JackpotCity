//
//  Effects.swift
//  Pinball
//
//  Created by 1 on 20.04.2022.
//

import SpriteKit


class SoundPlayer {
    
    private var currentTheme = ThemeManager.shared.currentTheme
    private var scene: SKScene!
    private var bamperSound: SKAction!
    private var flipperSound: SKAction!
    private var gameOverSound: SKAction!
    private var spawnBallSound: SKAction!
    
    init(scene: SKScene) {
        self.scene = scene
        bamperSound = SKAction.playSoundFileNamed(currentTheme.bamperSoundName, waitForCompletion: false)
        flipperSound = SKAction.playSoundFileNamed(currentTheme.flipperSoundName, waitForCompletion: false)
        gameOverSound = SKAction.playSoundFileNamed(currentTheme.gameOverSoundName, waitForCompletion: false)
        spawnBallSound = SKAction.playSoundFileNamed(currentTheme.spawnBallSoundName, waitForCompletion: false)
    }
    
    func playFlipperEffect() {
        playSoundEffect(sound: flipperSound)
    }
    
    func playBamperEffect() {
        playSoundEffect(sound: bamperSound, volume: 0.01)
    }
    
    func playGameOver() {
        playSoundEffect(sound: gameOverSound)
    }
    
    func playSpawnBallEffect() {
        playSoundEffect(sound: spawnBallSound)
    }
    
    private func playSoundEffect(sound: SKAction, volume: Float = 0.3) {
        let changeVolumeAction = SKAction.changeVolume(to: volume, duration: 3)
        let effectAudioGroup = SKAction.group([sound, changeVolumeAction])
        scene.run(effectAudioGroup)
    }
    
    private func configureSounds(audioNodes: [SKAudioNode]) {
        for node in audioNodes {
            node.autoplayLooped = false
            scene.addChild(node)
        }
    }
}
