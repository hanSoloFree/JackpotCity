//
//  Bamper.swift
//  Pinball
//
//  Created by 1 on 18.04.2022.
//

import SpriteKit

class Barrier: SKSpriteNode {
    
    func configure() {
        self.physicsBody?.categoryBitMask = BodyType.barrier.rawValue
        self.physicsBody?.collisionBitMask = BodyType.ball.rawValue
        self.physicsBody?.contactTestBitMask = BodyType.ball.rawValue
    }
}
