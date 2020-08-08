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

final class HomeViewController: UIViewController, HomeViewInput {
    
    // - Outlets
    var presenter: HomeViewOutput?
    
    // - Constants
    let locationManager = LocationManager()
    let locationLabel = UILabel()
    let button = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        createLabel()
        createButton()
        addSubViews()
        addConstraints()
        setCurrentLocation()
        presenter?.viewready()
        

    }

    
    //MARK: - Create label for location detection
    
    private func createLabel() {
        
        locationLabel.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        locationLabel.textAlignment = .center
        locationLabel.numberOfLines = 0

    }
        
    //MARK: - Create button
    
    private func createButton() {

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
