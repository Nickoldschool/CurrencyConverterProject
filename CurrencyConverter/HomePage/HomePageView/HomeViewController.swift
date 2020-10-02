//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Nick Chekmazov on 15.07.2020.
//  Copyright © 2020 Nick Chekmazov. All rights reserved.
//

import UIKit

protocol HomePageViewInput: AnyObject {
    
    func updateView()
}

protocol HomePageViewOutput {
    
    func viewready()
    
    func nextPage()
}

protocol PassData: AnyObject {
    
    // Try to convert it into function with these parametres for futher comfortable delegation
    var currencyConvertation: [CurrencyConvertation] {get set}
}

final class HomePageViewController: UIViewController, HomePageViewInput, PassData, UIGestureRecognizerDelegate {
    
    // - Outlets
    var presenter: HomePageViewOutput?
    
    // - Constants
    let locationLabel = UILabel()
    let button = UIButton()
    let infoLabel = UILabel()
    let recentConvertationsLabel = UILabel()
    
    //MARK: - Collection elements
    
    let layout = UICollectionViewFlowLayout()
    
    let homeCollectionView: UICollectionView = {
         
         let layout = UICollectionViewFlowLayout()
         
         layout.scrollDirection = .vertical
         
         let tempCV =  UICollectionView(frame: .zero, collectionViewLayout: layout)
         
         return tempCV
         
     }()
    
    var pulseLayers = [CAShapeLayer]()
    
    var currencyConvertation = [CurrencyConvertation]()
    var currencies = DataManager.shared.retrieveCurrencyConvertation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        setupCurrentLocation()
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressed))
        longPressRecognizer.minimumPressDuration = 0.5
        longPressRecognizer.delaysTouchesBegan = true
        longPressRecognizer.delegate = self
        self.view.addGestureRecognizer(longPressRecognizer)
    }
    
    @objc func longPressed(sender: UILongPressGestureRecognizer) {
        
        let longPressVC = LongpressViewController()
        
        longPressVC.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        present(longPressVC, animated: true, completion: nil)
        
        DataManager.shared.deleteAllCurrencyConvertation()
        currencies = DataManager.shared.retrieveCurrencyConvertation()
        homeCollectionView.reloadData()
        
        configureEmptyScreenMode()
        button.isHidden = false
        infoLabel.isHidden = false
        recentConvertationsLabel.isHidden = true
        
        print("Tapped")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        currencies = DataManager.shared.retrieveCurrencyConvertation()
        
        if currencies!.isEmpty {
            
            configureEmptyScreenMode()
            button.isHidden = false
            infoLabel.isHidden = false
            recentConvertationsLabel.isHidden = true
        } else {
            configureFilledScreenMode()
            puslsatingLayer.removeAllAnimations()
            puslsatingLayer.removeFromSuperlayer()
            removePulsation()
            button.isHidden = true
            infoLabel.isHidden = true
            recentConvertationsLabel.isHidden = false
            homeCollectionView.reloadData()
        }
        
    }
    
    private func registerPulsation() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(animatePulsatingLayer),
                                               name: Notification.Name(rawValue: "PulseAnimation"), object: nil);
        
    }
    
    //MARK: - Remove Keyboard Observer for Notification Center
    
    private func removePulsation() {
        
        NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue: "PulseAnimation"), object: nil)
    }
    
    //MARK: - Configure Elements
    
    private func configureEmptyScreenMode() {
        
        infoLabel.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        infoLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        infoLabel.text = "No current convertations,go to Exchange to convert"
        infoLabel.textAlignment = .center
        infoLabel.numberOfLines = 0
        
        button.layer.cornerRadius = 90
        button.layer.masksToBounds = true
        button.setTitleColor( #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal )
        button.setTitle("Choose currency", for: .normal)
        button.titleLabel?.font = UIFont(name: "Times New Roman", size:27)
        button.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping;
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = #colorLiteral(red: 0.3949316144, green: 0.02323797345, blue: 0.5600934625, alpha: 1)
        button.addTarget(self, action: #selector(moveToExchangeController), for: .touchUpInside)
        
        animatePulsatingLayer()
        
        view.addSubview(button)
        view.addSubview(infoLabel)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.heightAnchor.constraint(equalToConstant: 180),
            button.widthAnchor.constraint(equalToConstant: 180),
        ])
        
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            infoLabel.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 50),
            infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            infoLabel.heightAnchor.constraint(equalToConstant: 90),
            infoLabel.widthAnchor.constraint(equalToConstant: 250),
        ])
        
    }
    
    //MARK: - CollectionView
    
    private func configureFilledScreenMode() {
        
        recentConvertationsLabel.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        recentConvertationsLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        recentConvertationsLabel.text = "Recent convertations:"
        recentConvertationsLabel.textAlignment = .center
        recentConvertationsLabel.numberOfLines = 0
        
        view.addSubview(recentConvertationsLabel)

        recentConvertationsLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            recentConvertationsLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 10),
            recentConvertationsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            recentConvertationsLabel.heightAnchor.constraint(equalToConstant: 35),
            recentConvertationsLabel.widthAnchor.constraint(equalToConstant: 250),
        ])
        
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        layout.itemSize = CGSize(width: view.frame.width - 40, height: 45)
        homeCollectionView.delegate   = self
        homeCollectionView.dataSource = self
        homeCollectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
        homeCollectionView.backgroundColor = .white

        view.addSubview(homeCollectionView)
        
        homeCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            homeCollectionView.topAnchor.constraint(equalTo: recentConvertationsLabel.bottomAnchor, constant: 10),
            homeCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20),
            homeCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -20),
            homeCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
        ])
        
    }
    
    //MARK: - Setup current Location
        
    private func setupCurrentLocation() {
        
        locationLabel.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        locationLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        locationLabel.textAlignment = .center
        locationLabel.numberOfLines = 0
        
        view.addSubview(locationLabel)
        
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            locationLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
            locationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            locationLabel.heightAnchor.constraint(equalToConstant: 90),
            locationLabel.widthAnchor.constraint(equalToConstant: 250),
        ])
    }
    
    lazy var puslsatingLayer: CAShapeLayer = {
        let shape           = CAShapeLayer()
        shape.strokeColor   = #colorLiteral(red: 0.6424693465, green: 0.002870330121, blue: 0.9131718278, alpha: 1)
        shape.lineWidth     = 20
        shape.lineCap       = CAShapeLayerLineCap.round
        shape.fillColor     = #colorLiteral(red: 0.6424693465, green: 0.002870330121, blue: 0.9131718278, alpha: 1)
        
        return shape
    }()
    
    @objc private func animatePulsatingLayer() {
        
        view.layer.addSublayer(puslsatingLayer)
        puslsatingLayer.position    = view.center
        let circularPath            = UIBezierPath(arcCenter: .zero, radius: 90,
                                                   startAngle: -CGFloat.pi / 2,
                                                   endAngle: 2 * CGFloat.pi,
                                                   clockwise: true)
        puslsatingLayer.path        = circularPath.cgPath
        
        let animation               = CABasicAnimation(keyPath: "transform.scale")
        animation.fromValue         = 1.0
        animation.toValue           = 1.1
        animation.duration          = 1.2
        animation.timingFunction    = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        animation.autoreverses      = true
        animation.repeatCount       = Float.infinity
        puslsatingLayer.add(animation, forKey: "pulsating")
    }
    
    //MARK: - Call button for moving to next view
    
    @objc private func moveToExchangeController() {
        
        presenter?.nextPage()
        
        let blurView = BlurViewController()
        
        blurView.textLabel.text = "Please, go to Exchange page for convertation"
        blurView.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        present(blurView, animated: true, completion: nil)
        
    }

    func updateView() {
        
    }
}

