//
//  GameScenePhysics.swift
//  Pinball
//
//  Created by 1 on 19.04.2022.
//

import SpriteKit

extension GameScene {
    
    func didBegin(_ contact: SKPhysicsContact) {
        if hasContact(contact: contact, categoryA: BodyType.flipper.rawValue, categoryB: BodyType.flipperStop.rawValue) {
            let flipper: Flipper = getNode(contact: contact)
            flipper.lockFlipperUp()
        }
        else if hasContact(contact: contact, categoryA: BodyType.ball.rawValue, categoryB: BodyType.bamper.rawValue) {
            let bamper: Bamper = getNode(contact: contact)
            bamper.touched()
        }
    }
    
    private func hasContact(contact: SKPhysicsContact, categoryA: UInt32, categoryB: UInt32) -> Bool {
        let bodyA : SKPhysicsBody = contact.bodyA
        let bodyB : SKPhysicsBody = contact.bodyB
        if (bodyA.categoryBitMask == categoryA && bodyB.categoryBitMask == categoryB) {
            return true
        }
        if (bodyA.categoryBitMask == categoryB && bodyB.categoryBitMask == categoryA) {
            return true
        }
        return false
    }
    
    private func getNode<T>(contact: SKPhysicsContact) -> T {
        if let component = contact.bodyA.node as? T {
            return component
        }
        if let component = contact.bodyB.node as? T  {
            return component
        }
        fatalError()
    }
}

