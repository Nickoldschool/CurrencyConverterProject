//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Nick Chekmazov on 15.07.2020.
//  Copyright © 2020 Nick Chekmazov. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

protocol HomePageViewInput: AnyObject {
    
    func updateView()
}

protocol HomePageViewOutput {
    
    func viewready()
    
    func nextPage()
}

class HomePageViewController: UIViewController {
    
    // - Outlets
    var presenter: HomePageViewOutput?
    var locationManagerDelegate = CLLocationManager()
    
    // - Constants
    let locationManager = LocationManager()
    let locationLabel = UILabel()
    let mapView = MKMapView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        createLabel()
        createButton()
        showUserLocation()
        presenter?.viewready()
        setCurrentLocation()
        checkLocationEnabled()
        
    }

    
    //MARK: - Create label for location detection
    
    private func createLabel() {
        
        locationLabel.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        locationLabel.textAlignment = .center
        locationLabel.numberOfLines = 0
        view.addSubview(locationLabel)
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            locationLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 110),
            locationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            locationLabel.heightAnchor.constraint(equalToConstant: 90),
            locationLabel.widthAnchor.constraint(equalToConstant: 250),
        ])
    }
        
    //MARK: - Create button
    
    private func createButton() {

        let button = UIButton()
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 65
        button.layer.masksToBounds = true
        button.layer.borderColor =  #colorLiteral(red: 0.9920709729, green: 0.8178209662, blue: 0, alpha: 1)
        button.setTitleColor( .black, for: .normal )
        button.setTitle("Next", for: .normal)
        button.backgroundColor =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.addTarget(self, action: #selector(moveToExchangeController), for: .touchUpInside)
        view.addSubview(button)
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
        let vc = ExchangeTableController()
        navigationController?.pushViewController(vc,animated: true)
        
    }
    
    //MARK: - Create MapView
    
    private func showUserLocation() {
    
        mapView.showsUserLocation = true
        locationManagerDelegate.startUpdatingLocation()
        view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor, constant: 210),
            mapView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mapView.heightAnchor.constraint(equalToConstant: 350),
            mapView.widthAnchor.constraint(equalToConstant: 350),
        ])
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
            if let state = placemark.administrativeArea {
                output = output + "\n\(state)"
            }
            if let town = placemark.locality {
                output = output + "\n\(town)"
            }
            self.locationLabel.text = output
        }
    }
    
    //MARK: - Warned ueser to turn on location if it disabled
        
    private func checkLocationEnabled() {
        
        if CLLocationManager.locationServicesEnabled() {
            
            setManager()
            checkAuthorization()
            
        } else {
            
            let alert = UIAlertController(title: "Служба геолокации выключена", message: "Хотите включить", preferredStyle: .alert)
            let settingsAction = UIAlertAction(title: "Настройки", style: .default) { (alert) in
                if let url = URL(string: "App-Prefs:root=LOCATION_SERVICES") {
                    
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
            
            let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
            
            alert.addAction(settingsAction)
            alert.addAction(cancelAction)
            
            present(alert, animated: true ,completion: nil)
        }
        
    }
    
    //MARK: - Delegate and setUp desired accuracy of location

    private func setManager() {
        
        locationManagerDelegate.delegate = self
        locationManagerDelegate.desiredAccuracy = kCLLocationAccuracyBest
        
    }
    
    //MARK: - Checks if user is authorised, if not, asks permission
    
    private func checkAuthorization() {
        if CLLocationManager.authorizationStatus() == .authorizedAlways {
            mapView.showsUserLocation = true
            locationManagerDelegate.startUpdatingLocation()
            
        } else {
            
            locationManagerDelegate.requestWhenInUseAuthorization()
            
        }
    }

}

extension HomePageViewController: CLLocationManagerDelegate  {
    
    //MARK: - Function for setUp radius of location
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.last?.coordinate {
            
            let region = MKCoordinateRegion(center: location, latitudinalMeters: 5000, longitudinalMeters: 5000)
            mapView.setRegion(region, animated: true)
        }
    }
    
    //MARK: - Tracking authorization status
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        checkAuthorization()
    }
    
}

