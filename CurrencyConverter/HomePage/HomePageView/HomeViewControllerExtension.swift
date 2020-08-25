//
//  HomeViewControllerExtension.swift
//  CurrencyConverter
//
//  Created by Nick Chekmazov on 11.08.2020.
//  Copyright © 2020 Nick Chekmazov. All rights reserved.
//

import UIKit

    //MARK: - UICollectionViewDelegate & UICollectionViewDataSource

extension HomePageViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if currencies!.isEmpty  {
            return 0
        } else {
            return currencies!.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let currencyConv = currencies?[indexPath.row] else { return UICollectionViewCell() }
        guard let cell = homeCollectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as? HomeCollectionViewCell else { return UICollectionViewCell() }
        cell.updateData(currencyConvertation: currencyConv)
        return cell
    }

}

    // MARK: - UICollectionViewDelegateFlowLayout

extension HomePageViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return layout.itemSize
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return layout.sectionInset
    }
    
    func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
      currencies!.remove(at: indexPath.row)
      collectionView.deleteItems(at: [indexPath])
    }
    
}
