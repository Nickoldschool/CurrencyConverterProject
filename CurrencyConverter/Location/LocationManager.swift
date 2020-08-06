//
//  LocationManager.swift
//  CurrencyConverter
//
//  Created by Nick Chekmazov on 15.07.2020.
//  Copyright © 2020 Nick Chekmazov. All rights reserved.
//

import UIKit
import CoreLocation

class LocationManager: NSObject {
    
    // - Private
    private let locationManager = CLLocationManager()
    
    
    // - API
    public var exposedLocation: CLLocation? {
        return self.locationManager.location
    }
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
    }

}

// MARK: - Core Location Delegate
extension LocationManager: CLLocationManagerDelegate {
    

    
    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {
        
        
        switch status {
    
        case .notDetermined         : print("notDetermined")        // location permission not asked for yet
        case .authorizedWhenInUse   : print("authorizedWhenInUse")  // location authorized
        case .authorizedAlways      : print("authorizedAlways")     // location authorized
        case .restricted            : print("restricted")           // TODO: handle
        case .denied                : print("denied")               // TODO: handle
        @unknown default:
            fatalError()
        }
    }
}




// MARK: - Get Placemark
extension LocationManager {
    
    
    func getPlace(for location: CLLocation,
                  completion: @escaping (CLPlacemark?) -> Void) {
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            
            guard error == nil else {
                print("*** Error in \(#function): \(error!.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let placemark = placemarks?.first else {
                print("*** Error in \(#function): placemark is nil")
                completion(nil)
                return
            }
            
            completion(placemark)
        }
    }
    
    
}



// MARK: - Get Location
//extension LocationManager {
//    
//    
//    func getLocation(forPlaceCalled name: String,
//                            completion: @escaping(CLLocation?) -> Void) {
//        
//        let geocoder = CLGeocoder()
//        geocoder.geocodeAddressString(name) { placemarks, error in
//            
//            guard error == nil else {
//                print("*** Error in \(#function): \(error!.localizedDescription)")
//                completion(nil)
//                return
//            }
//            
//            guard let placemark = placemarks?[0] else {
//                print("*** Error in \(#function): placemark is nil")
//                completion(nil)
//                return
//            }
//            
//            guard let location = placemark.location else {
//                print("*** Error in \(#function): placemark is nil")
//                completion(nil)
//                return
//            }
//
//            completion(location)
//        }
//    }
//}

