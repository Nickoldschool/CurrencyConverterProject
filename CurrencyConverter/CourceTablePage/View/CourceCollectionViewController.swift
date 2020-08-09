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
    let currentCurrencyLabel = UILabel()
    let dateLabel = UILabel()
    
    //MARK: - Virables
    
    var networkManager = NetworkManager()
    var currenntCurrency: String = "EUR"
    var rates = [Rate]()
    
    var myCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

        configureLabels()
        configureTableView()
        addSubViews()
        addConstraints()
        
        networkManager.getCurrencies(rate: currenntCurrency) { (currencies, error) in
            DispatchQueue.main.async {
                self.rates.removeAll()
                for (key, value) in currencies!.rates {
                    self.rates.append(Rate(currency: key, rate: value))
                }
//                self.currentCurrencyLabel.text = "Current currency: \(currencies!.base)"
                self.currentCurrencyLabel.text = currencies!.base
                self.dateLabel.text = "Last update: \(currencies!.date)"
                self.myCollectionView.reloadData()
            }
        }
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
    
    private func configureLabels() {
        
        currentCurrencyLabel.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        currentCurrencyLabel.layer.cornerRadius = 55
        currentCurrencyLabel.textAlignment = .center
        currentCurrencyLabel.layer.masksToBounds = true
        
        dateLabel.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        dateLabel.layer.cornerRadius = 5
        dateLabel.textAlignment = .center
        dateLabel.layer.masksToBounds = true
        
    }
    
    private func addSubViews() {
        
        view.addSubview(myCollectionView)
        view.addSubview(currentCurrencyLabel)
        view.addSubview(dateLabel)
        
    }
    
    private func addConstraints() {
        
        myCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            myCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 260),
            myCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20),
            myCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -20),
            myCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
        ])
        
        currentCurrencyLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            currentCurrencyLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            currentCurrencyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            currentCurrencyLabel.heightAnchor.constraint(equalToConstant: 110),
            currentCurrencyLabel.widthAnchor.constraint(equalToConstant: 110),
        ])
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: currentCurrencyLabel.bottomAnchor, constant: 15),
            dateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dateLabel.heightAnchor.constraint(equalToConstant: 25),
            dateLabel.widthAnchor.constraint(equalToConstant: 220),
        ])
        
    }
    
}

// MARK: - UICollectionViewDelegate & UICollectionViewDataSource

extension CourceCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if rates.isEmpty {
            return 0
        } else {
            return rates.count
        }
//        return 32
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let rate = rates[indexPath.row]
        let cell = myCollectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! CourceCollectionViewCell
        cell.updateData(rate: rate, entery: 0)
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

