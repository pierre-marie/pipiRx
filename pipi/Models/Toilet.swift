//
//  Toilet.swift
//  pipi
//
//  Created by pierre-marie de jaureguiberry on 5/23/18.
//  Copyright © 2018 vo2. All rights reserved.
//

import Foundation
import MapKit

struct Toilet {
    
    var record_id: String
    var record_timestamp: String
    var latitude: Double
    var longitude: Double
    var opening_time: String
    var district: String
    var street_name: String
    var street_number: String
}

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
