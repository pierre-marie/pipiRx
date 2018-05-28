//
//  ToiletViewModel.swift
//  pipi
//
//  Created by pierre-marie de jaureguiberry on 5/23/18.
//  Copyright © 2018 vo2. All rights reserved.
//

import Foundation
import RxSwift
import MapKit

struct ToiletViewModel {

    private let toiletsVariable = Variable([])
    var toilets:Observable<Array<Any>> {
        return toiletsVariable.asObservable()
    }
    
    func fetchToiletAnnotations() -> Array<ToiletAnnotation> {
        
        var toiletAnnotations = Array<ToiletAnnotation>()
        for toilet in self.toiletsVariable.value {
            
            let toilet = toilet as! Toilet
            let t = ToiletAnnotation(title: toilet.opening_time, locationName: toilet.record_timestamp, coordinate: CLLocationCoordinate2DMake(toilet.latitude, toilet.longitude))
            toiletAnnotations.append(t)
        }
        return toiletAnnotations
    }
    
    func switchValueChanged(switchIsOn: Bool) {
        
        if (!switchIsOn) {
            fetchToilets()
        } else {
            let dataArray = self.toiletsVariable.value as! Array<Toilet>
            self.toiletsVariable.value = dataArray.filter {
                $0.opening_time.contains("24 h / 24")
            }
        }
    }
    
    func fetchToilets() {
        
        ToiletService.shared.getToiletsFromApi(success: { (response) -> Void in
            self.toiletsVariable.value = response!
        }) { (error) -> Void in
            
        }
    }
}
