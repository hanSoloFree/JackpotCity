//
//  MenuScene.swift
//  Pinball
//
//  Created by 1 on 21.04.2022.
//

import SpriteKit

class MenuScene: SKScene {
    
    var soundPlayer: SoundPlayer?
    var gameViewController: GameViewController?
    
    override func didMove(to view: SKView) {
        soundPlayer = SoundPlayer(scene: self)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
}
