//
//  ToiletAnnotation.swift
//  pipi
//
//  Created by pierre-marie de jaureguiberry on 5/25/18.
//  Copyright © 2018 vo2. All rights reserved.
//

import UIKit
import MapKit

class ToiletAnnotation: NSObject, MKAnnotation {
    
    let title: String?
    let locationName: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, coordinate: CLLocationCoordinate2D) {
        
        self.title = title
        self.locationName = locationName
        self.coordinate = coordinate
        super.init()
    }
    
    var subtitle: String? {
        return ""
    }
}
