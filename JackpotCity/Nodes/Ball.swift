//
//  Ball.swift
//  Pinball
//
//  Created by 1 on 18.04.2022.
//

import SpriteKit

class Ball: SKSpriteNode {
    
    private var bottomLastPoint: CGFloat = 0.0
    private var spawnPoint = CGPoint(x: 0.0, y: 0.0)
    private var isAutoSpawn = true
    private var gameScene: GameScene!
    private let theme = ThemeManager.shared.currentTheme
    private var lastBottomPoint: CGFloat = 0
    
    func configure(sceneHeight: CGFloat, spawnPoint: CGPoint, scene: GameScene) {
        self.gameScene = scene
        self.lastBottomPoint = spawnPoint.y
        self.physicsBody?.mass = 0.1
        self.texture = SKTexture(imageNamed: theme.ballImageName)
        self.bottomLastPoint = -(sceneHeight * 0.5) - self.size.height * 0.5
        self.spawnPoint = spawnPoint
        self.physicsBody?.categoryBitMask = BodyType.ball.rawValue
        self.physicsBody?.collisionBitMask = BodyType.flipper.rawValue | BodyType.ball.rawValue | BodyType.bamper.rawValue | BodyType.barrier.rawValue
        self.physicsBody?.contactTestBitMask = BodyType.flipper.rawValue | BodyType.ball.rawValue | BodyType.bamper.rawValue | BodyType.barrier.rawValue
    }
    
    func checkIfResetBall() {
        if self.position.y < (lastBottomPoint + self.size.height/2) {
            if self.position.x > 500 && !isAutoSpawn {
                gameScene.plusExtraLife()
            }
            resetBall()
        }
    }
    
    private func resetBall() {
        gameScene.extraLife = gameScene.lives.last!
        gameScene.lives.last?.isHidden = true
        gameScene.lives.removeLast()
        guard !gameScene.isGameOver, gameScene.lives.count > 0 else { return }
        isAutoSpawn = true
        DispatchQueue.main.asyncAfter(deadline: .now()+0.2) {
            self.isAutoSpawn = false
        }
        gameScene.soundPlayer?.playSpawnBallEffect()
        
        let spawnPosition = spawnPoint
        self.position = spawnPosition
        self.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        var randomImpulse = 0
        switch theme {
        case .classic:
            randomImpulse = Array(200...1000).randomElement()!
        case .golf:
            randomImpulse = Array(400...700).randomElement()!
        case .baseball:
            randomImpulse = Array(300...600).randomElement()!
        case .tennis:
            randomImpulse = Array(200...500).randomElement()!
        }
        
        self.physicsBody?.applyImpulse(CGVector(dx: 0, dy: randomImpulse))
    }
}
