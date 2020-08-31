//
//  TableViewController.swift
//  CurrencyConverter
//
//  Created by Nick Chekmazov on 28.07.2020.
//  Copyright © 2020 Nick Chekmazov. All rights reserved.
//

import UIKit

protocol CourceCollectionPageViewInput: AnyObject {
    
}

protocol CourceCollectionPageViewOutput {
    
}

final class CourceCollectionPageViewController: UIViewController, CourceCollectionPageViewInput {
    
    var presenter: CourceCollectionPageViewOutput?
    
    //MARK: - Constants
    
    let layout = UICollectionViewFlowLayout()
    
    let purpleView = UIView()
    let currentCurrencyLabel = UILabel()
    let dateLabel = UILabel()
    let selectCurrencyButton = UIButton()
    let enterTextField = UITextField()
    
    var firstRate: Double {
        return Double(enterTextField.text ?? "") ?? 0
    }
    
    //MARK: - Virables
    
    var networkManager = NetworkManager()
    var currenntCurrency: String = "EUR"
    var rates = [Rate]()
    
    var myCollectionView: UICollectionView!
    
    var selectedCurrencyObserver: NSObjectProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: false )
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        configureLabels()
        configureTableView()
        addSubViews()
        addConstraints()
        
        callNetwork()
        callCurrencyObserver()
    }
    
    //MARK: - CollectionView
    
    private func configureTableView() {
        
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        layout.itemSize = CGSize(width: view.frame.width - 40, height: 45)
        myCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        myCollectionView.delegate   = self
        myCollectionView.dataSource = self
        myCollectionView.register(CourceCollectionPageViewCell.self, forCellWithReuseIdentifier: CourceCollectionPageViewCell.identifier)
        myCollectionView.backgroundColor = UIColor.white
        if let flowLayout = myCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .vertical
        }
        
    }
    
    //MARK: - Configure Labels
    
    private func configureLabels() {
        
        purpleView.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        purpleView.layer.cornerRadius = 5
        
        currentCurrencyLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        currentCurrencyLabel.textAlignment = .center
        currentCurrencyLabel.layer.masksToBounds = true
        
        dateLabel.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        dateLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        dateLabel.layer.cornerRadius = 5
        dateLabel.textAlignment = .center
        dateLabel.layer.masksToBounds = true
        
        selectCurrencyButton.addTarget(self, action: #selector(handleSelect), for: .touchUpInside)
        selectCurrencyButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        selectCurrencyButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        selectCurrencyButton.setTitle("Select currency", for: .normal)
        selectCurrencyButton.layer.cornerRadius = 5
        selectCurrencyButton.titleLabel?.textAlignment = .center
        selectCurrencyButton.layer.masksToBounds = true
        
        enterTextField.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        enterTextField.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        enterTextField.textAlignment = .center
        enterTextField.keyboardType = .numberPad
        enterTextField.layer.cornerRadius = 5
        enterTextField.attributedPlaceholder = NSAttributedString(string: "Please,enter ammount", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray ])
        
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(handleClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        enterTextField.inputAccessoryView = toolBar
        
        //MARK: - method for dynamically change converted value
        enterTextField.addTarget(self, action: #selector(callNetwork), for: .editingChanged)
    }
    
    
    //MARK:- Picker View Button
    @objc func handleClick() {
        enterTextField.resignFirstResponder()
    }
    
    //MARK: - Call PopUpCOntroller with currencies Picker View
    
    @objc public func handleSelect(){
        let selectVC = UINavigationController(rootViewController: PopUpViewController())
        selectVC.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        present(selectVC, animated: true, completion: nil)
    }
    
    //MARK: - Get Currencies rates
    
    @objc private func callNetwork() {
        
        networkManager.getCurrencies(rate: currenntCurrency) { (currencies, error) in
            DispatchQueue.main.async {
                self.rates.removeAll()
                for (key, value) in currencies!.rates {
                    self.rates.append(Rate(currency: key, rate: value))
                }
                self.currentCurrencyLabel.text = currencies!.base
                self.dateLabel.text = "Last update: \(currencies!.date)"
                self.myCollectionView.reloadData()
            }
        }
        
    }
    
    //MARK: - Call Observer for dynamically change current currency
    
    private func callCurrencyObserver() {
        
        selectedCurrencyObserver    = NotificationCenter.default.addObserver(forName: .selectedCurrency, object: nil, queue: OperationQueue.main, using: { (notification) in
            let selectVc            = notification.object as! PopUpViewController
            self.currenntCurrency   = selectVc.selectedCurrency!
            self.callNetwork()
        })
    }
    
    //MARK: - Add SubViews
    
    private func addSubViews() {
        
        view.addSubview(purpleView)
        purpleView.addSubview(currentCurrencyLabel)
        purpleView.addSubview(dateLabel)
        purpleView.addSubview(selectCurrencyButton)
        purpleView.addSubview(enterTextField)
        view.addSubview(myCollectionView)
        
    }
    
    //MARK: - Add Constraints
    
    private func addConstraints() {
        
        purpleView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            purpleView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            purpleView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            purpleView.heightAnchor.constraint(equalToConstant: 140),
            purpleView.widthAnchor.constraint(equalToConstant: view.bounds.width - 40),
        ])
        
        currentCurrencyLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            currentCurrencyLabel.topAnchor.constraint(equalTo: purpleView.topAnchor, constant: 3),
            currentCurrencyLabel.trailingAnchor.constraint(equalTo: purpleView.trailingAnchor, constant: -10),
            currentCurrencyLabel.heightAnchor.constraint(equalToConstant: 25),
            currentCurrencyLabel.widthAnchor.constraint(equalToConstant: 50),
        ])
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: purpleView.topAnchor, constant: 3),
            dateLabel.leadingAnchor.constraint(equalTo: purpleView.leadingAnchor, constant: 10),
            dateLabel.heightAnchor.constraint(equalToConstant: 25),
            dateLabel.widthAnchor.constraint(equalToConstant: 220),
        ])
        
        enterTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            enterTextField.bottomAnchor.constraint(equalTo: selectCurrencyButton.topAnchor, constant: -15),
            enterTextField.centerXAnchor.constraint(equalTo: purpleView.centerXAnchor),
            enterTextField.heightAnchor.constraint(equalToConstant: 35),
            enterTextField.widthAnchor.constraint(equalToConstant: view.bounds.width - 80),
        ])
        
        selectCurrencyButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            selectCurrencyButton.bottomAnchor.constraint(equalTo: purpleView.bottomAnchor, constant: -15),
            selectCurrencyButton.centerXAnchor.constraint(equalTo: purpleView.centerXAnchor),
            selectCurrencyButton.heightAnchor.constraint(equalToConstant: 35),
            selectCurrencyButton.widthAnchor.constraint(equalToConstant: view.bounds.width - 80),
        ])
        
        myCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            myCollectionView.topAnchor.constraint(equalTo: purpleView.bottomAnchor, constant: 5),
            myCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20),
            myCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -20),
            myCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
        ])
        
    }
    
}
