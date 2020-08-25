//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Nick Chekmazov on 15.07.2020.
//  Copyright © 2020 Nick Chekmazov. All rights reserved.
//

import UIKit
import CoreLocation

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

final class HomePageViewController: UIViewController, HomePageViewInput, PassData {
    
    // - Outlets
    var presenter: HomePageViewOutput?
    
    // - Constants
    let locationManager = LocationManager()
    let locationLabel = UILabel()
    let button = UIButton()

    
    //MARK: - Collection elements
    
    let layout = UICollectionViewFlowLayout()
    var homeCollectionView: UICollectionView!
    
    var currencyConvertation = [CurrencyConvertation]()
    var currencies = DataManager.shared.retrieveCurrencyConvertation()
    
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
        homeCollectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
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
        
    }
    
    private func addSubViews() {
        
        view.addSubview(locationLabel)
        view.addSubview(button)
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
            button.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 50),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.heightAnchor.constraint(equalToConstant: 130),
            button.widthAnchor.constraint(equalToConstant: 130),
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
        
        let exVC = ExchangePageViewController()
        navigationController?.pushViewController(exVC, animated: true)
    }
    
    //MARK: - Call button for moving to next view
    
    @objc private func moveToExchangeController() {
        
        presenter?.nextPage()
        let ExVC = ExchangePageViewController()
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

