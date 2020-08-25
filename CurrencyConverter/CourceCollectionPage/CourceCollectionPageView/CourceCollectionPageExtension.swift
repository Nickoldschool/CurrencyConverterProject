//
//  CourceCollectionExtention.swift
//  CurrencyConverter
//
//  Created by Nick Chekmazov on 11.08.2020.
//  Copyright © 2020 Nick Chekmazov. All rights reserved.
//

import UIKit
// MARK: - UICollectionViewDelegate & UICollectionViewDataSource

extension CourceCollectionPageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if rates.isEmpty {
            return 0
        } else {
            return rates.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let rate = rates[indexPath.row]
        guard let cell = myCollectionView.dequeueReusableCell(withReuseIdentifier: CourceCollectionPageViewCell.identifier, for: indexPath) as? CourceCollectionPageViewCell else { return UICollectionViewCell() }
        cell.updateData(rate: rate, entery: self.firstRate)
        return cell
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CourceCollectionPageViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return layout.itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return layout.sectionInset
    }
}

