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
    
    let currentCurrencyButton = UIButton()
    let selectCurrencyButton = UIButton()
    let dateLabel = UILabel()
    
    //MARK: - Virables
    
    var networkManager = NetworkManager()
    var currenntCurrency: String = "EUR"
    var rates = [Rate]()
    
    var myCollectionView: UICollectionView!
    
    var selectedCurrencyObserver: NSObjectProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

        configureLabels()
        configureTableView()
        addSubViews()
        addConstraints()
    
        callNetwork()
        callCurrencyObserver()
    }
    
//    lazy var puslsatingLayer: CAShapeLayer = {
//        let shape           = CAShapeLayer()
//        shape.strokeColor   = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
//        shape.lineWidth     = 10
//        shape.lineCap       = CAShapeLayerLineCap.round
//        shape.fillColor     = UIColor(named: "system")?.withAlphaComponent(0.3).cgColor
//
//        return shape
//    }()
//
//    private func animatePulsatingLayer(){
//        let animation               = CABasicAnimation(keyPath: "transform.scale")
//        animation.toValue           = 1.3
//        animation.duration          = 1.2
//        animation.timingFunction    = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
//        animation.autoreverses      = true
//        animation.repeatCount       = Float.infinity
//        puslsatingLayer.add(animation, forKey: "pulsating")
//    }
//
//        func layoutSubviews() {
//            currentCurrencyButton.layoutSubviews()
//            puslsatingLayer.position    = currentCurrencyButton.center
//            let circularPath            = UIBezierPath(arcCenter: .zero, radius: 50,
//                                                       startAngle: -CGFloat.pi / 2,
//                                                       endAngle: 2 * CGFloat.pi,
//                                                       clockwise: true)
//            puslsatingLayer.path        = circularPath.cgPath
//        }
    
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
        
        currentCurrencyButton.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        currentCurrencyButton.layer.cornerRadius = 55
        currentCurrencyButton.titleLabel?.textAlignment = .center
        currentCurrencyButton.layer.masksToBounds = true
        //currentCurrencyButton.addTarget(self, action: #selector(handleSelect), for: .touchUpInside)
//        currentCurrencyButton.layer.addSublayer(puslsatingLayer)
//        animatePulsatingLayer()
//        layoutSubviews()
        
        dateLabel.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        dateLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        dateLabel.layer.cornerRadius = 5
        dateLabel.textAlignment = .center
        dateLabel.layer.masksToBounds = true
        
        selectCurrencyButton.addTarget(self, action: #selector(handleSelect), for: .touchUpInside)
        selectCurrencyButton.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        selectCurrencyButton.setTitle("Select currency", for: .normal)
        selectCurrencyButton.layer.cornerRadius = 5
        selectCurrencyButton.titleLabel?.textAlignment = .center
        selectCurrencyButton.layer.masksToBounds = true
        
    }
    
    //MARK: - Call PopUpCOntroller with currencies Picker View
    
    @objc public func handleSelect(){
        let selectVC = UINavigationController(rootViewController: PopUpViewController())
        selectVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        present(selectVC, animated: true, completion: nil)
    }
    
    //MARK: - Get Currencies rates
    
    private func callNetwork() {
        
        networkManager.getCurrencies(rate: currenntCurrency) { (currencies, error) in
            DispatchQueue.main.async {
                self.rates.removeAll()
                for (key, value) in currencies!.rates {
                    self.rates.append(Rate(currency: key, rate: value))
                }
                self.currentCurrencyButton.setTitle(currencies!.base, for: .normal)
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
        
        view.addSubview(myCollectionView)
        view.addSubview(currentCurrencyButton)
        view.addSubview(dateLabel)
        view.addSubview(selectCurrencyButton)
        
    }
    
    //MARK: - Add Constraints
    
    private func addConstraints() {
        
        currentCurrencyButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            currentCurrencyButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            currentCurrencyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            currentCurrencyButton.heightAnchor.constraint(equalToConstant: 110),
            currentCurrencyButton.widthAnchor.constraint(equalToConstant: 110),
        ])
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: currentCurrencyButton.bottomAnchor, constant: 15),
            dateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dateLabel.heightAnchor.constraint(equalToConstant: 25),
            dateLabel.widthAnchor.constraint(equalToConstant: 220),
        ])
        
        selectCurrencyButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            selectCurrencyButton.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10),
            selectCurrencyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            selectCurrencyButton.heightAnchor.constraint(equalToConstant: 35),
            selectCurrencyButton.widthAnchor.constraint(equalToConstant: 220),
        ])
        
        
        myCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            myCollectionView.topAnchor.constraint(equalTo: selectCurrencyButton.bottomAnchor, constant: 10),
            myCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20),
            myCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -20),
            myCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
        ])
        
    }
    
}

