//
//  Bamper.swift
//  Pinball
//
//  Created by 1 on 18.04.2022.
//

import SpriteKit

class Bamper: SKSpriteNode {
    
    private var gameScene: GameScene!
    var currentTheme = ThemeManager.shared.currentTheme
    
    func configure(scene: GameScene) {
        self.gameScene = scene
        self.physicsBody?.categoryBitMask = BodyType.bamper.rawValue
        self.physicsBody?.collisionBitMask = BodyType.ball.rawValue
        self.physicsBody?.contactTestBitMask = BodyType.ball.rawValue
    }
    
    func touched() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        gameScene.soundPlayer?.playBamperEffect()
        calculateScore()
    }
    
    private func calculateScore() {
        guard let name = self.name else { return }
        switch currentTheme {
        case .classic:
            gameScene.score += classicScore(name: name)
        case .golf:
            gameScene.score += classicScore(name: name)
        case .baseball:
            gameScene.score += classicScore(name: name)
        case .tennis:
            gameScene.score += classicScore(name: name)
        }
    }
    
    private func classicScore(name: String) -> Int {
        guard let bamperName = BanperName(rawValue: name) else { return 0}
        switch bamperName {
        case .bamperA:
            return currentTheme.numberOfScore * 20
        case .bamperB:
            return currentTheme.numberOfScore * 5
        case .bamperC:
            return currentTheme.numberOfScore
        case .bamperD:
            return currentTheme.numberOfScore
        }
    }
}

enum BanperName: String {
    case bamperA
    case bamperB
    case bamperC
    case bamperD
}

struct BamperProperty {
    let size: CGSize
    let texture: SKTexture
    let position: CGPoint
    let name: BanperName
}
