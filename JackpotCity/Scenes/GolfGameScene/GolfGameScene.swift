//
//  GolfGameScene.swift
//  Pinball
//
//  Created by 1 on 18.04.2022.
//

import SpriteKit
import GameplayKit

class GolfGameScene: GameScene {
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        sceneWidth = self.frame.width
        sceneHeight = self.frame.height
        configureLifesBarNodes()
        configureNodes(nodes: children)
        configureBacground()
        AudioPlayer.shared.setupMusic()
        AudioPlayer.shared.playMusic()
        soundPlayer = SoundPlayer(scene: self)
        ballSpawnPosition = CGPoint(x: 513, y: -786)
    }
    
    override func update(_ currentTime: TimeInterval) {
        guard lives.count > 0 else {
            gameOver()
            return
        }
        leftFlipper.update()
        rightFlipper.update()
        
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { timer in
            if !self.lives.isEmpty {
                self.mainBall.checkIfResetBall()
            }
            timer.invalidate()
        }
    }
}
