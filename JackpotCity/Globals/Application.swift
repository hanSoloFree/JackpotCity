//
//  Application.swift
//  Pinball
//
//  Created by 1 on 26.04.2022.
//

import UIKit

final class Application {
    
    static var shared = Application()
    
    private init() {}
    
    var isFirstInitial = false
    
    var classicBestResult: Int {
        get {
            return UserDefaults.standard.integer(forKey: UserDefaultsKey.classicBestResult.rawValue)
        }
        set(newValue) {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKey.classicBestResult.rawValue)
        }
    }
    
    var golfBestResult: Int {
        get {
            return UserDefaults.standard.integer(forKey: UserDefaultsKey.golfBestResult.rawValue)
        }
        set(newValue) {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKey.golfBestResult.rawValue)
        }
    }
    
    var baseballBestResult: Int {
        get {
            return UserDefaults.standard.integer(forKey: UserDefaultsKey.baseballBestResult.rawValue)
        }
        set(newValue) {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKey.baseballBestResult.rawValue)
        }
    }
    
    var tennisBestResult: Int {
        get {
            return UserDefaults.standard.integer(forKey: UserDefaultsKey.tennisBestResult.rawValue)
        }
        set(newValue) {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKey.tennisBestResult.rawValue)
        }
    }
    
    enum UserDefaultsKey: String {
        case classicBestResult
        case golfBestResult
        case baseballBestResult
        case tennisBestResult
    }
}

