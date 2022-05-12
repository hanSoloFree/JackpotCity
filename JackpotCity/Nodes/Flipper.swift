//
//  Flipper.swift
//  Pinball
//
//  Created by 1 on 18.04.2022.
//

import SpriteKit

enum FlipperType: String {
    case right = "rightFlipper"
    case left = "leftFlipper"
}

class Flipper: SKSpriteNode {
    
    var startPosition: CGPoint = .zero
    var upperRotation: CGFloat = 0
    var lowerRotation: CGFloat = 0
    private var isDown = true
    private let theme = ThemeManager.shared.currentTheme
    
    func configure(currentTheme: Theme) {
        self.texture = SKTexture(imageNamed: self.name == FlipperType.left.rawValue ? currentTheme.flipperLeftImageName : currentTheme.flipperRightImageName)
        startPosition = self.position
        self.physicsBody?.categoryBitMask = BodyType.flipper.rawValue
        self.physicsBody?.collisionBitMask = BodyType.flipperStop.rawValue | BodyType.ball.rawValue
        self.physicsBody?.contactTestBitMask = BodyType.flipperStop.rawValue | BodyType.ball.rawValue
        
        if self.name == FlipperType.right.rawValue {
            upperRotation = -30
            lowerRotation = 20
            self.zRotation = degreesToRadians(degrees: lowerRotation)
        }
        else if self.name == FlipperType.left.rawValue {
            upperRotation = 30
            lowerRotation = -20
            self.zRotation = degreesToRadians(degrees: lowerRotation)
        }
    }
    
    func moveUp() {
        if isDown {
            isDown = false
            self.physicsBody?.isDynamic = true
            self.physicsBody?.allowsRotation = true
            let impuls = CGVector(dx: 0, dy: theme == .tennis ? 7000 : 2000)
            self.physicsBody?.applyImpulse(impuls)
        }
    }
    
    func moveDown() {
        isDown = true
        self.physicsBody?.isDynamic = true
        self.physicsBody?.allowsRotation = true
        self.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        self.physicsBody?.angularVelocity = 0
        self.physicsBody?.mass = 0.5
        
        let flip = SKAction.rotate(byAngle: degreesToRadians(degrees: lowerRotation), duration: 0.1)
        let run = SKAction.run {
            self.lockFlipperDown()
        }
        self.run(SKAction.sequence([flip, run]), withKey: "LowerThenLock")
    }
    
    func update() {
        self.position = startPosition
        
        if self.name == FlipperType.right.rawValue {
            if self.zRotation > degreesToRadians(degrees: lowerRotation) {
                self.zRotation = degreesToRadians(degrees: lowerRotation)
            }
            else if self.zRotation < degreesToRadians(degrees: upperRotation) {
                self.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                self.physicsBody?.applyTorque(0)
                self.physicsBody?.angularVelocity = 0
                self.zRotation = degreesToRadians(degrees: upperRotation)
            }
        }
        else  if self.name == FlipperType.left.rawValue {
            if self.zRotation < degreesToRadians(degrees: lowerRotation) {
                self.zRotation = degreesToRadians(degrees: lowerRotation)
            }
            else if self.zRotation > degreesToRadians(degrees: upperRotation) {
                self.zRotation = degreesToRadians(degrees: upperRotation)
            }
        }
    }
    
    func lockFlipperUp() {
        self.zRotation = degreesToRadians(degrees: upperRotation)
        lockFlipper()
    }
    
    private func lockFlipperDown() {
        self.zRotation = degreesToRadians(degrees: lowerRotation)
        lockFlipper()
    }
    
    private func lockFlipper() {
        self.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        self.physicsBody?.angularVelocity = 0
        self.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 0))
        self.physicsBody?.isDynamic = false
        self.physicsBody?.allowsRotation = false
    }
    
    private func radiansToDegrees(radians: CGFloat) -> CGFloat {
        return radians * 180 / .pi
    }
    
    private func degreesToRadians(degrees: CGFloat) -> CGFloat {
        return degrees * .pi / 180
    }
}
