//
//  Lights.swift
//  Pinball
//
//  Created by 1 on 18.04.2022.
//

import SpriteKit

class Lights: SKSpriteNode {
    
    var timer: Timer!
    
    func configure(currentTheme: Theme) {
        self.isHidden = currentTheme == .golf
        let taxtureA = SKTexture(imageNamed: "ligts-1")
        let taxtureB = SKTexture(imageNamed: "ligts-2")
        let taxtureC = SKTexture(imageNamed: "ligts-3")
        let textureList = [taxtureA, taxtureB, taxtureC]
        let animationAction = SKAction.animate(with: textureList, timePerFrame: 0.2)
        timer = Timer.scheduledTimer(withTimeInterval: 0.6, repeats: true, block: { _ in
            self.run(animationAction)
        })
    }
    
    deinit {
        timer.invalidate()
    }
    
    
}
