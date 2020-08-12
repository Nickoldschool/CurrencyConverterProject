//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Nick Chekmazov on 15.07.2020.
//  Copyright © 2020 Nick Chekmazov. All rights reserved.
//

import UIKit
import CoreLocation

protocol HomeViewInput: AnyObject {
    
    func updateView()
}

protocol HomeViewOutput {
    
    func viewready()
    
    func nextPage()
}

protocol PassData: AnyObject {

    // Try to convert it into function with these parametres for futher comfortable delegation
    var firstLabel:  UILabel { get }
    var secondLabel: UILabel { get }
    var thirdabel:   UILabel { get }
    var fourthLabel: UILabel { get }
    var currencyConvertation: [CurrencyConvertation] {get set}
}

final class HomeViewController: UIViewController, HomeViewInput, PassData {
    
    // - Outlets
    var presenter: HomeViewOutput?
    
    // - Constants
    let locationManager = LocationManager()
    let locationLabel = UILabel()
    let button = UIButton()
    
    let firstLabel  = UILabel()
    let secondLabel = UILabel()
    let thirdabel   = UILabel()
    let fourthLabel = UILabel()
    
    //MARK: - Collection elements
    
    let myidentifier = "MyCell"
    let layout = UICollectionViewFlowLayout()
    var homeCollectionView: UICollectionView!
    
    var currencyConvertation = [CurrencyConvertation]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        configureTableView()
        configureElements()
        addSubViews()
        addConstraints()
        setCurrentLocation()
        presenter?.viewready()
    }
    
    //MARK: - CollectionView
    
    private func configureTableView() {

        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        layout.itemSize = CGSize(width: view.frame.width - 40, height: 45)
        homeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        homeCollectionView.delegate   = self
        homeCollectionView.dataSource = self
        homeCollectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: myidentifier)
        homeCollectionView.backgroundColor = .white
        if let flowLayout = homeCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .vertical
        }

    }
        
    //MARK: - Configure Elements
    
    private func configureElements() {
        
        locationLabel.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        locationLabel.textAlignment = .center
        locationLabel.numberOfLines = 0

        button.layer.borderWidth = 2
        button.layer.cornerRadius = 65
        button.layer.masksToBounds = true
        button.layer.borderColor =  #colorLiteral(red: 0.9920709729, green: 0.8178209662, blue: 0, alpha: 1)
        button.setTitleColor( .black, for: .normal )
        button.setTitle("Choose currency", for: .normal)
        button.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping;
        button.titleLabel?.textAlignment = .center
        button.backgroundColor =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.addTarget(self, action: #selector(moveToExchangeController), for: .touchUpInside)
        
        firstLabel.textColor  = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        secondLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        thirdabel.textColor   = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        fourthLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        firstLabel.backgroundColor  = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        secondLabel.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        thirdabel.backgroundColor   = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        fourthLabel.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)

    }
    
    private func addSubViews() {
        
        view.addSubview(locationLabel)
        view.addSubview(button)
        view.addSubview(firstLabel)
        view.addSubview(secondLabel)
        view.addSubview(thirdabel)
        view.addSubview(fourthLabel)
        view.addSubview(homeCollectionView)
    }
    
    private func addConstraints() {
        
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            locationLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
            locationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            locationLabel.heightAnchor.constraint(equalToConstant: 90),
            locationLabel.widthAnchor.constraint(equalToConstant: 250),
        ])
        
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -110),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.heightAnchor.constraint(equalToConstant: 130),
            button.widthAnchor.constraint(equalToConstant: 130),
        ])
        
        firstLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            firstLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 250),
            firstLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            firstLabel.heightAnchor.constraint(equalToConstant: 40),
            firstLabel.widthAnchor.constraint(equalToConstant: 130),
        ])
        
        secondLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            secondLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 350),
            secondLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            secondLabel.heightAnchor.constraint(equalToConstant: 40),
            secondLabel.widthAnchor.constraint(equalToConstant: 130),
        ])
        
        thirdabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            thirdabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            thirdabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            thirdabel.heightAnchor.constraint(equalToConstant: 40),
            thirdabel.widthAnchor.constraint(equalToConstant: 130),
        ])
        
        fourthLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            fourthLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 300),
            fourthLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            fourthLabel.heightAnchor.constraint(equalToConstant: 40),
            fourthLabel.widthAnchor.constraint(equalToConstant: 130),
            
        ])
                
        homeCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            homeCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 400),
            homeCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20),
            homeCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -20),
            homeCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
        ])
    
    }
    
    @objc private func pushToModelVC() {
        
        let exVC = ExchangeViewController()
        navigationController?.pushViewController(exVC, animated: true)
    }
    
    //MARK: - Call button for moving to next view
    
    @objc private func moveToExchangeController() {
        
        presenter?.nextPage()
        let ExVC = ExchangeViewController()
        navigationController?.pushViewController(ExVC,animated: true)
        
    }
    
    //MARK: - Function for showing current location: Country&city
    
    private func setCurrentLocation() {
        
        guard let exposedLocation = self.locationManager.exposedLocation else {
            print("*** Error in \(#function): exposedLocation is nil")
            return
        }
        
        self.locationManager.getPlace(for: exposedLocation) { placemark in
            guard let placemark = placemark else { return }
            
            var output = "Our location is:"
            if let country = placemark.country {
                output = output + "\n\(country)"
            }
            if let town = placemark.locality {
                output = output + "\n\(town)"
            }
            self.locationLabel.text = output
        }
    }
    
    func updateView() {
        
    }
    
}

