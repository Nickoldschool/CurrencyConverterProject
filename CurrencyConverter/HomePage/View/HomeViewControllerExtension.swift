//
//  HomeViewControllerExtension.swift
//  CurrencyConverter
//
//  Created by Nick Chekmazov on 11.08.2020.
//  Copyright © 2020 Nick Chekmazov. All rights reserved.
//

import UIKit

    //MARK: - UICollectionViewDelegate & UICollectionViewDataSource

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if currencyConvertation.isEmpty {
            return 0
        } else {
           return currencyConvertation.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let currencyConv = currencyConvertation[indexPath.row]
        let cell = homeCollectionView.dequeueReusableCell(withReuseIdentifier: myidentifier, for: indexPath) as! HomeCollectionViewCell
        cell.updateData(currencyConvertation: currencyConv)
        return cell
    }

}

    // MARK: - UICollectionViewDelegateFlowLayout

extension HomeViewController: UICollectionViewDelegateFlowLayout {

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
      currencyConvertation.remove(at: indexPath.row)
      collectionView.deleteItems(at: [indexPath])
    }
}
