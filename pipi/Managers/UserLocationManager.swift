//
//  UserLocationManager.swift
//  pipi
//
//  Created by pierre-marie de jaureguiberry on 5/24/18.
//  Copyright © 2018 vo2. All rights reserved.
//

import UIKit
import MapKit
import RxSwift

class UserLocationManager: NSObject, CLLocationManagerDelegate {

    static let shared = UserLocationManager()
    
    private let userLocationVariable = Variable(CLLocation())
    var userLocation:Observable<CLLocation> {
        return userLocationVariable.asObservable()
    }
    
    var locationManager:CLLocationManager!
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        let userLocation:CLLocation = locations[0] as CLLocation
        self.userLocationVariable.value = userLocation
    }
    
    func determineCurrentLocation() {
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.distanceFilter = 50
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    
}
