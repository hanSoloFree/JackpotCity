//
//  ThemeCollectionView.swift
//  Pinball
//
//  Created by 1 on 22.04.2022.
//

import UIKit

extension GameViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ThemeCollectionViewCell", for: indexPath) as! ThemeCollectionViewCell
        let theme = dataSource[indexPath.row]
        cell.theme = theme
        return cell
    }
    
    private func currentCell(scrollView: UIScrollView, collectionView: UICollectionView) -> UICollectionViewCell? {
        guard var closestCell = collectionView.visibleCells.first else { return nil }
        for cell in collectionView.visibleCells as [UICollectionViewCell] {
            let closestCellDelta = abs(closestCell.center.x - collectionView.bounds.size.width/2.0 - collectionView.contentOffset.x)
            let cellDelta = abs(cell.center.x - collectionView.bounds.size.width/2.0 - collectionView.contentOffset.x)
            if (cellDelta < closestCellDelta) {
                closestCell = cell
            }
        }
        return closestCell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let currentThemCell = currentCell(scrollView: scrollView, collectionView: themeCollectionView), let themeCell = currentThemCell as? ThemeCollectionViewCell, let theme = themeCell.theme {
            self.bestResultLabel.alpha = theme.isAvailable ? 1 : 0
            UIView.animate(withDuration: 0.3) {
                self.bestResultLabel.text = theme.bestResult
                
                self.startLabel.alpha = theme.isAvailable ? 1 : 0
                self.bestResultTitleLabel.text = theme.isAvailable ? "Best result" : "To unlock this level, beat the record of \(theme.recordLevel) points on the previous level"
                self.bestResultTitleLabel.font =  self.bestResultTitleLabel.font.withSize(theme.isAvailable ? 50 : 30)
            }
        }
    }
}
