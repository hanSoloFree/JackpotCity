//
//  ThemeManager.swift
//  Pinball
//
//  Created by 1 on 20.04.2022.
//

import Foundation
import SpriteKit

class ThemeManager {
    
    static let shared = ThemeManager()
    
    var currentTheme: Theme = .classic
}

enum Theme: CaseIterable {
    case classic
    case golf
    case baseball
    case tennis
    
    var bestResult: String {
        switch self {
        case .classic:
            return Application.shared.classicBestResult.description
        case .golf:
            return Application.shared.golfBestResult.description
        case .baseball:
            return Application.shared.baseballBestResult.description
        case .tennis:
            return Application.shared.tennisBestResult.description
        }
    }
    
    var flipperRightImageName: String {
        switch self {
        case .classic:
            return "right-flipper"
        case .golf:
            return "golf-right-flipper"
        case .baseball:
            return "baseball-right-flipper"
        case .tennis:
            return "tennis-right-flipper"
        }
    }
    
    var flipperLeftImageName: String {
        switch self {
        case .classic:
            return "left-flipper"
        case .golf:
            return "golf-left-flipper"
        case .baseball:
            return "baseball-left-flipper"
        case .tennis:
            return "tennis-left-flipper"
        }
    }
    
    var ballImageName: String {
        switch self {
        case .classic:
            return "classic-ball"
        case .golf:
            return "golf-ball"
        case .baseball:
            return "baseball-ball"
        case .tennis:
            return "tennis-ball"
        }
    }
    
    var bamperAImageName: String {
        switch self {
        case .classic:
            return "classic-bamper-A"
        case .golf:
            return "golf-bamper-A"
        case .baseball:
            return "baseball-bamper-A"
        case .tennis:
            return "classic-bamper-A"
        }
    }
    
    var bamperBImageName: String {
        switch self {
        case .classic:
            return "classic-bamper-B"
        case .golf:
            return "golf-bamper-B"
        case .baseball:
            return "baseball-bamper-B"
        case .tennis:
            return "classic-bamper-B"
        }
    }
    
    var bamperCImageName: String {
        switch self {
        case .classic:
            return "classic-bamper-C"
        case .golf:
            return "golf-bamper-C"
        case .baseball:
            return "baseball-bamper-C"
        case .tennis:
            return "classic-bamper-C"
        }
    }
    
    var gameBackgroundImageName: String {
        switch self {
        case .classic:
            return "bg-game-classic"
        case .golf:
            return "bg-game-golf"
        case .baseball:
            return "bg-game-baseball"
        case .tennis:
            return "bg-game-tennis"
        }
    }
    
    var gameThemeImageName: String {
        switch self {
        case .classic:
            return "classic-logo"
        case .golf:
            return "golf-logo"
        case .baseball:
            return "baseball-logo"
        case .tennis:
            return "tennis-logo"
        }
    }
    
    var flipperSoundName: String {
        switch self {
        case .classic:
            return "flipper-classic.wav"
        case .golf:
            return "flipper-golf.wav"
        case .baseball:
            return "flipper-baseball.wav"
        case .tennis:
            return "flipper-tannis.wav"
        }
    }
    
    var bamperSoundName: String {
        switch self {
        case .classic:
            return "bamper-classic.wav"
        case .golf:
            return "bamper-golf.wav"
        case .baseball:
            return "bamper-baseball.wav"
        case .tennis:
            return "bamper-tannis.wav"
        }
    }
    
    var gameSoundName: String {
        switch self {
        case .classic:
            return "game"
        case .golf:
            return "game-golf"
        case .baseball:
            return "game-baseball"
        case .tennis:
            return "game-tennis"
        }
    }
    
    var gameOverSoundName: String {
        switch self {
        case .classic:
            return "game-over.wav"
        case .golf:
            return "game-over-golf.wav"
        case .baseball:
            return "baseball-game-over.wav"
        case .tennis:
            return "tennis-game-over.wav"
        }
    }
    
    var spawnBallSoundName: String {
        switch self {
        case .classic:
            return "spawn-ball-classic.wav"
        case .golf:
            return "spawn-ball-classic.wav"
        case .baseball:
            return "spawn-ball-classic.wav"
        case .tennis:
            return "spawn-ball-classic.wav"
        }
    }
    
    var extraLifeSoundName: String {
        switch self {
        case .classic, .golf, .baseball, .tennis :
            return "extra-life.wav"
        }
    }
    
    var numberOfScore: Int {
        switch self {
        case .classic:
            return 10
        case .golf:
            return 5
        case .baseball:
            return 3
        case .tennis:
            return 2
        }
    }
    
    var gameScene: GameScene? {
        switch self {
        case .classic:
            return PinballGameScene(fileNamed: "PinballGameScene")
        case .golf:
            return GolfGameScene(fileNamed: "GolfGameScene")
        case .baseball:
            return BaseballGameScene(fileNamed: "BaseballGameScene")
        case .tennis:
            return TennisGameScene(fileNamed: "TennisGameScene")
        }
    }
    
    var isAvailable: Bool {
        switch self {
        case .classic:
            return true
        case .golf:
            return Application.shared.classicBestResult > recordLevel
        case .baseball:
            return Application.shared.golfBestResult > recordLevel
        case .tennis:
            return Application.shared.baseballBestResult > recordLevel
        }
    }
    
    var recordLevel: Int {
        switch self {
        case .classic:
            return 0
        case .golf:
            return 10000
        case .baseball:
            return 2000
        case .tennis:
            return 1000
        }
    }
    
    static var allowedCases: [Theme] {
        return Theme.allCases
    }
}
