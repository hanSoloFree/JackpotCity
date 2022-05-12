//
//  GolfGameScene.swift
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

class GolfGameScene: SKScene, SKPhysicsContactDelegate {
    var gameViewController: GameViewController?
    private var sceneWidth: CGFloat = 0
    private var sceneHeight: CGFloat = 0
    private var leftFlipper: Flipper!
    private var rightFlipper: Flipper!
    private var ballSpawnPosition = CGPoint(x: 517, y: -786)
    private var scoreLabel: SKLabelNode!
    private var currentTheme = ThemeManager.shared.currentTheme
    var mainBall = Ball()
    var soundPlayer: SoundPlayer?
    var lives: [SKSpriteNode] = [SKSpriteNode()]
    var extraLife = SKSpriteNode()
    var starScore = 0
    var score = 0 {
        didSet {
            scoreLabel?.text = "Score: \(score.description)"
        }
    }
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        sceneWidth = self.frame.width
        sceneHeight = self.frame.height
        configureLifesBarNodes()
        configureNodes()
        configureBacground()
        AudioPlayer.shared.setupMusic()
        AudioPlayer.shared.playMusic()
        soundPlayer = SoundPlayer(scene: self)
    }
    
    override func update(_ currentTime: TimeInterval) {
        guard lives.count > 0 else {
            gameOver()
            return
        }
        leftFlipper.update()
        rightFlipper.update()
        
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { timer in
            if !self.lives.isEmpty {
                self.mainBall.checkIfResetBall()
            }
            timer.invalidate()
        }
    }
    
    private func gameOver() {
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
    
    private func setupClassicScene() {
        let arrowsLeft = SKSpriteNode(texture: SKTexture(image: UIImage(named: "arrows-classic-left")!))
        let arrowsRight = SKSpriteNode(texture: SKTexture(image: UIImage(named: "arrows-classic-right")!))
        arrowsLeft.position = CGPoint(x: -375, y: 421)
        arrowsRight.position = CGPoint(x: 281, y: 421)
        self.addChild(arrowsLeft)
        self.addChild(arrowsRight)
    }
    
    private func configureLifesBarNodes() {
        let lifeA = childNode(withName: "lifeA") as! SKSpriteNode
        let lifeB = childNode(withName: "lifeB") as! SKSpriteNode
        let lifeC = childNode(withName: "lifeC") as! SKSpriteNode
        lives.append(lifeA)
        lives.append(lifeB)
        lives.append(lifeC)
        lives.forEach({$0.texture = SKTexture(imageNamed: currentTheme.ballImageName)})
        extraLife = lives.last!
    }
    
    private func configureBacground() {
        let backgroundNode = childNode(withName: "gameBackground") as! SKSpriteNode
        backgroundNode.texture = SKTexture(imageNamed: currentTheme.gameBackgroundImageName)
        
    }
    
    private func configureNodes() {
        for node in children {
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
                ball.configure(sceneHeight: self.sceneHeight, spawnPoint: ballSpawnPosition, currentTheme: self.currentTheme, scene: self)
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
        switch currentTheme {
        case .classic:
            setupClassicScene()
        case .golf:
            setupClassicScene()
        case .baseball:
            setupClassicScene()
        case .tennis:
            setupClassicScene()
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
