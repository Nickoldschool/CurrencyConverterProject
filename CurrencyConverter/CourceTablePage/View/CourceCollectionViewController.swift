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
    let lastUpdateLabel = UILabel()
    let currentCurrencyLabel =  UILabel()
    let layout = UICollectionViewFlowLayout()
    
    
    //MARK: - Virables
    
    var currenntCurrency: String = "EUR"
    var rates = [Rate]()
    var ratesKey = [String]()
    var ratesValue = [Double]()
    var myCollectionView: UICollectionView!
    
    //var rates: [String] = ["USD: 1.1725", "SGD: 1.6142", "PLN: 4.4194", "KRW: 1400.22", "JPY: 123.28", "CHF: 1.0766", "BRL: 6.0149", "SEK: 10.287", "HUF: 347.67", "IDR: 17042.29", "ISK: 159.0", "MYR: 4.9755", "RUB: 84.9125", "ILS: 3.9985", "MXN: 25.631", "CNY: 8.2067", "TRY: 8.1748", "NZD: 1.764", "AUD: 1.6348", "CAD: 1.5665", "CZK: 26.291", "BGN: 1.9558", "GBP: 0.90385", "HRK: 7.494", "ZAR: 19.3269", "HKD: 9.0869", "INR: 87.694", "NOK: 10.6573", "PHP: 57.538", "THB: 36.899", "DKK: 7.4427", "RON: 4.8345"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
      
        configureTableView()
        loadRates(currency: currenntCurrency)
        
    }
    
    
    private func setupLabels() {

        lastUpdateLabel.textAlignment = .center
        currentCurrencyLabel.textAlignment = .center
        view.addSubview(lastUpdateLabel)
        view.addSubview(currentCurrencyLabel)
        
        currentCurrencyLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
           currentCurrencyLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 115),
           currentCurrencyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
           currentCurrencyLabel.heightAnchor.constraint(equalToConstant: 30),
           currentCurrencyLabel.widthAnchor.constraint(equalToConstant: 200),
        ])
        
        lastUpdateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
           lastUpdateLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 145),
           lastUpdateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
           lastUpdateLabel.heightAnchor.constraint(equalToConstant: 30),
           lastUpdateLabel.widthAnchor.constraint(equalToConstant: 200),
        ])
        
    }
    
    //MARK: - CollectionView
    
    private func configureTableView() {
        
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        layout.itemSize = CGSize(width: view.frame.width - 40, height: 45)
        myCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        myCollectionView.delegate   = self
        myCollectionView.dataSource = self
        myCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: identifier)
        myCollectionView.backgroundColor = UIColor.white
        if let flowLayout = myCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .vertical
        }
        
        view.addSubview(myCollectionView)
        myCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            myCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
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
        
        let cell = myCollectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) //as! CourceCollectionViewCell
        cell.backgroundColor = .orange
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

