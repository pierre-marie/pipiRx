//
//  ToiletViewModel.swift
//  pipi
//
//  Created by pierre-marie de jaureguiberry on 5/23/18.
//  Copyright © 2018 vo2. All rights reserved.
//

import Foundation
import RxSwift

struct ToiletViewModel {
    
    private let toiletsVariable = Variable([])
    var toilets:Observable<Array<Any>> {
        return toiletsVariable.asObservable()
    }
    
    func fetchToilets() {
        
        ToiletService.shared.getToiletsFromApi(success: { (response) -> Void in
            self.toiletsVariable.value = response!
        }) { (error) -> Void in
            
        }
    }
}
