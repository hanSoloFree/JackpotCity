//
//  GameScene.swift
//  Pinball
//
//  Created by 1 on 18.04.2022.
//

import SpriteKit
import GameplayKit

enum BodyType: UInt32 {
    case ball = 2
    case bamper = 4
    case flipper = 8
    case flipperStop = 16
    case barrier = 32
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    var gameViewController: GameViewController?
    var sceneWidth: CGFloat = 0
    var sceneHeight: CGFloat = 0
    var leftFlipper: Flipper!
    var rightFlipper: Flipper!
    var ballSpawnPosition = CGPoint(x: 517, y: -786)
    var scoreLabel: SKLabelNode!
    var currentTheme = ThemeManager.shared.currentTheme
    var mainBall = Ball()
    var soundPlayer: SoundPlayer?
    var lives: [SKSpriteNode] = [SKSpriteNode()]
    var extraLife = SKSpriteNode()
    var starScore = 0
    var isGameOver = false
    var score = 0 {
        didSet {
            scoreLabel?.text = "Score: \(score.description)"
        }
    }
    
    func gameOver() {
        isGameOver = true
        gameViewController?.showCollectionView()
        AudioPlayer.shared.stopMusic()
        soundPlayer?.playGameOver()
        if score > (Int(currentTheme.bestResult) ?? 0) {
            gameViewController?.bestResultLabel.text = score.description
            switch currentTheme {
            case .classic:
                Application.shared.classicBestResult = score
            case .golf:
                Application.shared.golfBestResult = score
            case .baseball:
                Application.shared.baseballBestResult = score
            case .tennis:
                Application.shared.tennisBestResult = score
            }
        }
        if let menuScene = MenuScene(fileNamed: "MenuScene") {
            menuScene.gameViewController = gameViewController
            menuScene.scaleMode = scaleMode
            let transition = SKTransition.doorsCloseHorizontal(withDuration: 1)
            self.view?.presentScene(menuScene, transition: transition)
        }
    }
    
    func configureLifesBarNodes() {
        let lifeA = childNode(withName: "lifeA") as! SKSpriteNode
        let lifeB = childNode(withName: "lifeB") as! SKSpriteNode
        let lifeC = childNode(withName: "lifeC") as! SKSpriteNode
        lives.append(lifeA)
        lives.append(lifeB)
        lives.append(lifeC)
        lives.forEach({$0.texture = SKTexture(imageNamed: currentTheme.ballImageName)})
        extraLife = lives.last!
        lives.last?.isHidden = true
    }
    
    func configureBacground() {
        let backgroundNode = childNode(withName: "gameBackground") as! SKSpriteNode
        backgroundNode.texture = SKTexture(imageNamed: currentTheme.gameBackgroundImageName)
        
    }
    
    func configureNodes(nodes: [SKNode]) {
        for node in nodes {
            if let flipper = node as? Flipper {
                flipper.configure(currentTheme: currentTheme)
                if flipper.name == FlipperType.left.rawValue {
                    leftFlipper = flipper
                }
                else if flipper.name == FlipperType.right.rawValue {
                    rightFlipper = flipper
                }
            }
            else if let flipperStopper = node as? FlipperStop {
                flipperStopper.configure()
            }
            else if let ball = node as? Ball {
                ball.configure(sceneHeight: self.sceneHeight, spawnPoint: ballSpawnPosition, scene: self)
                self.mainBall = ball
            }
            else if let bamper = node as? Bamper {
                bamper.configure(scene: self)
            }
            else if let label = node as? SKLabelNode {
                self.scoreLabel = label
            }
            else if let lights = node as? Lights {
                lights.configure(currentTheme: self.currentTheme)
            }
            else if let barrier = node as? Barrier {
                barrier.configure()
            }
        }
    }
    
    func plusExtraLife() {
        lives.append(extraLife)
    }
    
    func touchesBeganLeft() {
        leftFlipper.moveUp()
    }
    
    func touchesBeganRight() {
        rightFlipper.moveUp()
    }
    
    func touchesEndedLeft() {
        leftFlipper.moveDown()
    }
    
    func touchesEndedRight() {
        rightFlipper.moveDown()
    }
}
