//
//  Toilet+CoreDataClass.swift
//  pipi
//
//  Created by pierre-marie de jaureguiberry on 5/25/18.
//  Copyright © 2018 vo2. All rights reserved.
//
//

import Foundation
import Realm
import RealmSwift
import Unbox

public class Toilet: Object, Unboxable {
    
    @objc dynamic var record_id = ""
    @objc dynamic var record_timestamp = ""
    @objc dynamic var latitude = 0.0
    @objc dynamic var longitude = 0.0
    @objc dynamic var opening_time = ""
    @objc dynamic var district = ""
    @objc dynamic var street_name = ""
    @objc dynamic var street_number = ""
    
    public required init(unboxer: Unboxer) throws {
        
        super.init()
        
        self.record_id = try unboxer.unbox(key: "recordid")
        self.record_timestamp = try unboxer.unbox(key: "record_timestamp")
        self.latitude = try unboxer.unbox(keyPath: "fields.geom_x_y.0")
        self.longitude = try unboxer.unbox(keyPath: "fields.geom_x_y.1")
        self.opening_time = try unboxer.unbox(keyPath: "fields.horaires_ouverture")
        self.district = try unboxer.unbox(keyPath: "fields.arrondissement")
        self.street_name = try unboxer.unbox(keyPath: "fields.nom_voie")
//        self.street_number = try unboxer.unbox(keyPath: "fields.numero_voie")
    }
    
    required public init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
    
    required public init() {
        super.init()
    }
    
    required public init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    override public static func primaryKey() -> String? {
        return "record_id"
    }
    
    func getAll() -> [Toilet] {
        
        let realm = try! Realm()
        let toilets = realm.objects(Toilet.self)
        return Array(toilets)
    }
}
