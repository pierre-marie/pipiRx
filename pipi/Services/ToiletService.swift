//
//  ToiletService.swift
//  pipi
//
//  Created by pierre-marie de jaureguiberry on 5/23/18.
//  Copyright © 2018 vo2. All rights reserved.
//

import UIKit
import Alamofire

class ToiletService: NSObject {

    static let shared = ToiletService()
    
    //MARK: Get toilets from API
    func getToiletsFromApi(success: @escaping (_ response: Array<Toilet>?) -> Void,
                           failure: @escaping (_ error: NSError?) -> Void) {
        
        let urlString: String = "https://opendata.paris.fr/api/records/1.0/search/?dataset=sanisettesparis2011&facet=arrondissement&facet=horaires_ouverture"
        
        Alamofire.request(urlString, method: .get, parameters: nil, encoding: URLEncoding.default).validate().responseJSON { response in
            switch response.result {
            case .success:
                
                if let result = response.result.value {
                    let JSON = result as! NSDictionary
                    let records = JSON.object(forKey:"records") as! NSArray

                    var toilets = Array<Toilet>()
                    
                    for record in records {
                        let r = record as! NSDictionary
                        let fields = r.object(forKey: "fields") as! NSDictionary
                        let geom = fields.object(forKey: "geom") as! NSDictionary
                        let coordinates = geom.object(forKey: "coordinates") as! NSArray
                        
                        let t = Toilet(record_id: r.value(forKey: "recordid") as! String,
                                       record_timestamp: r.value(forKey: "record_timestamp") as! String,
                                       latitude: coordinates[0] as! Double,
                                       longitude: coordinates[1] as! Double,
                                       opening_time: fields.value(forKey: "horaires_ouverture") as! String,
                                       district: fields.value(forKey: "arrondissement") as! String,
                                       street_name: fields.value(forKey: "nom_voie") as! String,
                                       street_number: fields.value(forKey: "numero_voie") as! String)
                        toilets.append(t)
                    }
                    
                    success(toilets)
                }
                
            case .failure:
                failure(response.result.error! as NSError?)
            }
        }
    }
}
