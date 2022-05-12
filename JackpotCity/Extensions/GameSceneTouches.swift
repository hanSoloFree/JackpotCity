//
//  GameSceneTouches.swift
//  Pinball
//
//  Created by 1 on 18.04.2022.
//

import SpriteKit

extension GameScene {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if location.x < -48 {
                touchesBeganLeft()
            } else {
                touchesBeganRight()
            }
            soundPlayer?.playFlipperEffect()
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if location.x < -48 {
                touchesEndedLeft()
            } else {
                touchesEndedRight()
            }
        }
    }
}
