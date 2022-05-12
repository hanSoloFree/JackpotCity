//
//  CollectionViewCell.swift
//  Pinball
//
//  Created by 1 on 22.04.2022.
//

import UIKit

final class ThemeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lockImageView: UIImageView!
    
    @IBOutlet weak var alphaView: UIView! {
        didSet {
            alphaView.layer.cornerRadius = 12
        }
    }
    
    @IBOutlet weak var themeImageView: UIImageView! {
        didSet {
            themeImageView.layer.cornerRadius = 10
        }
    }
    
    var theme: Theme? {
        didSet {
            configureCell()
        }
    }
    
    func configureCell() {
        guard let theme = theme else { return }
        lockImageView.isHidden = theme.isAvailable
        alphaView.isHidden = theme.isAvailable
        themeImageView.image = UIImage(named: theme.gameThemeImageName)
    }
}
