//
//  GameViewController.swift
//  Pinball
//
//  Created by 1 on 18.04.2022.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var resultStackViewTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var collectionViewBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var startBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var themeCollectionView: UICollectionView!
    
    @IBOutlet weak var bestResultTitleLabel: UILabel! {
        didSet {
            bestResultTitleLabel.text = "Best result"
        }
    }
    
    @IBOutlet weak var startLabel: UILabel! {
        didSet {
            startLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(startButtonDidTap)))
        }
    }
    
    @IBOutlet weak var bestResultLabel: UILabel! {
        didSet {
            bestResultLabel.text = Application.shared.classicBestResult.description
        }
    }
    
    var dataSource: [Theme] = Theme.allowedCases
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .allButUpsideDown
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let view = self.view as! SKView? {
            if let scene = SKScene(fileNamed: "MenuScene") as? MenuScene {
                scene.gameViewController = self
                scene.scaleMode = .aspectFill
                view.presentScene(scene)
            }
            view.ignoresSiblingOrder = false
            view.showsFPS = false
            view.showsNodeCount = false
        }
        configuresCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showCollectionView()
    }
    
    private func configuresCollectionView() {
        let layout1 = UPCarouselFlowLayout()
        layout1.itemSize = CGSize(width: 200, height: 200)
        layout1.scrollDirection = .horizontal
        themeCollectionView.collectionViewLayout = layout1
    }
    
    func showCollectionView() {
        DispatchQueue.main.async {
            self.collectionViewBottomConstraint.constant = 200
            self.resultStackViewTopConstraint.constant = 12
            UIView.animate(withDuration: 0.3, delay: 1) {
                self.view.layoutIfNeeded()
            } completion: { _ in
                self.startBottomConstraint.constant = 100
                UIView.animate(withDuration: 0.2) {
                    self.view.layoutIfNeeded()
                }
            }
        }
    }
    
    @objc func startButtonDidTap() {
        collectionViewBottomConstraint.constant = -250
        resultStackViewTopConstraint.constant = -200
        self.startBottomConstraint.constant = -120
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        if let themeCell = themeCollectionView.visibleCells.first(where: {$0.alpha > 0.9}) as? ThemeCollectionViewCell, let theme = themeCell.theme {
            ThemeManager.shared.currentTheme = theme
        }
        if let view = self.view as! SKView? {
            let gameScene = ThemeManager.shared.currentTheme.gameScene
            gameScene?.gameViewController = self
            gameScene?.scaleMode = .aspectFill
            let transition = SKTransition.doorway(withDuration: 1.2)
            view.presentScene(gameScene!, transition: transition)
        }
    }
}
