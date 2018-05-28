//
//  ToiletService.swift
//  pipi
//
//  Created by pierre-marie de jaureguiberry on 5/23/18.
//  Copyright © 2018 vo2. All rights reserved.
//

import UIKit
import Alamofire
import Unbox
import RealmSwift

class ToiletService: NSObject {
    
    static let shared = ToiletService()
    
    //MARK: Get toilets from API
    func getToiletsFromApi(success: @escaping (_ response: Array<Toilet>?) -> Void,
                           failure: @escaping (_ error: NSError?) -> Void) {
        
        let urlString: String = "https://opendata.paris.fr/api/records/1.0/search/?dataset=sanisettesparis2011&facet=arrondissement&facet=horaires_ouverture&rows=900"
        
        Alamofire.request(urlString, method: .get, parameters: nil, encoding: URLEncoding.default).validate().responseJSON { response in
            switch response.result {
            case .success:
                
                if let result = response.result.value {
                    
                    let JSON = result as! NSDictionary
                    let records = JSON.object(forKey:"records") as! NSArray
                    let realm = try! Realm()
                    
                    for record in records {
                        let r = record as! NSDictionary
                        do {
                            let t = try unbox(dictionary: r as! UnboxableDictionary) as Toilet
                            try! realm.write() {
                                realm.add(t, update: true)
                            }
                        } catch {
                            // ...
                        }
                    }
                    let toilets = Toilet().getAll()
                    success(toilets)
                }
                
            case .failure:
                failure(response.result.error! as NSError?)
            }
        }
    }
}
