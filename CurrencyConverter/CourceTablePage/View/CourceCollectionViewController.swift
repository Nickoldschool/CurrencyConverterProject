//
//  TableViewController.swift
//  CurrencyConverter
//
//  Created by Nick Chekmazov on 28.07.2020.
//  Copyright © 2020 Nick Chekmazov. All rights reserved.
//

import UIKit

final class CourceCollectionViewController: UIViewController {
    
    
    //MARK: - Constants
    
    
    let identifier = "MyCell"
    let layout = UICollectionViewFlowLayout()
    
    
    
    //MARK: - Virables
    
    var currenntCurrency: String = "EUR"
    var ratesKey = [String]()
    var ratesValue = [Double]()
    var myCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        configureTableView()
        addSubViews()
        addConstraints()
    }
    
    //MARK: - CollectionView
    
    private func configureTableView() {
        
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        layout.itemSize = CGSize(width: view.frame.width - 40, height: 45)
        myCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        myCollectionView.delegate   = self
        myCollectionView.dataSource = self
        myCollectionView.register(CourceCollectionViewCell.self, forCellWithReuseIdentifier: identifier)
        myCollectionView.backgroundColor = UIColor.white
        if let flowLayout = myCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .vertical
        }
        
    }
    
    private func addSubViews() {
        
        view.addSubview(myCollectionView)
    }
    
    private func addConstraints() {
        
        myCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            myCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 250),
            myCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20),
            myCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -20),
            myCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
        ])
        
    }
    
}

// MARK: - UICollectionViewDelegate & UICollectionViewDataSource

extension CourceCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 32
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = myCollectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! CourceCollectionViewCell
        return cell
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CourceCollectionViewController: UICollectionViewDelegateFlowLayout {
    
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

