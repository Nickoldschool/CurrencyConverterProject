//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Nick Chekmazov on 15.07.2020.
//  Copyright © 2020 Nick Chekmazov. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    // - Outlets
    let locationLabel = UILabel()
    //var locationManager: CLLocationManager?
    
    // - Constants
    let locationManager = LocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = .white
        
        createLabel()
        createButton()
        setCurrentLocation()
    }

    
    //MARK: - Create label for location detection
    
    private func createLabel() {
        
        locationLabel.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        locationLabel.textAlignment = .center
        locationLabel.numberOfLines = 0
        view.addSubview(locationLabel)
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            locationLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            locationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            locationLabel.heightAnchor.constraint(equalToConstant: 90),
            locationLabel.widthAnchor.constraint(equalToConstant: 250),
        ])
    }
    
    //MARK: - Function for current location inentifying
    
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
            if let state = placemark.administrativeArea {
                output = output + "\n\(state)"
            }
            if let town = placemark.locality {
                output = output + "\n\(town)"
            }
            self.locationLabel.text = output
        }
    }
    
    //MARK: - Create button
    
    private func createButton() {
        
        let button = UIButton()
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 75
        button.layer.masksToBounds = true
        button.layer.borderColor =  #colorLiteral(red: 0.9920709729, green: 0.8178209662, blue: 0, alpha: 1)
        button.setTitleColor( .black, for: .normal )
        button.setTitle("Next", for: .normal)
        button.backgroundColor =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.addTarget(self, action: #selector(moveToExchangeController), for: .touchUpInside)
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: view.topAnchor, constant: 400),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.heightAnchor.constraint(equalToConstant: 150),
            button.widthAnchor.constraint(equalToConstant: 150),
        ])
    }
    
    //MARK: - Call button for moving to next view
    
    @objc func moveToExchangeController() {
        
        let vc = ExchangeTableController()
        navigationController?.pushViewController(vc,animated: true)
        
    }

}

