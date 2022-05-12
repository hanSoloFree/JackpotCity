//
//  FlipperStop.swift
//  Pinball
//
//  Created by 1 on 18.04.2022.
//

import SpriteKit

class FlipperStop: SKSpriteNode {
    
    func configure() {
        self.physicsBody?.categoryBitMask = BodyType.flipperStop.rawValue
        self.physicsBody?.collisionBitMask = BodyType.flipper.rawValue
        self.physicsBody?.contactTestBitMask = BodyType.flipper.rawValue
    }
}
