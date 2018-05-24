//
//  ToiletView.swift
//  pipi
//
//  Created by pierre-marie de jaureguiberry on 5/24/18.
//  Copyright © 2018 vo2. All rights reserved.
//

import MapKit

internal final class ToiletView: MKMarkerAnnotationView {
    internal override var annotation: MKAnnotation? { willSet { newValue.flatMap(configure(with:)) } }
}

private extension ToiletView {
    func configure(with annotation: MKAnnotation) {
        //guard annotation is ToiletView else { fatalError("Unexpected annotation type: \(annotation)") }
        markerTintColor = .purple
        glyphImage = #imageLiteral(resourceName: "bathroom")
        clusteringIdentifier = String(describing: ToiletView.self)
    }
}
