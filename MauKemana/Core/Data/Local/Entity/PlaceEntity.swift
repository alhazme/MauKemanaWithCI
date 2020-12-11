//
//  PlaceEntity.swift
//  MauKemana
//
//  Created by Moch Fariz Al Hazmi on 01/11/20.
//

import Foundation
import RealmSwift

class PlaceEntity: Object {

    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var desc: String = ""
    @objc dynamic var address: String = ""
    @objc dynamic var longitude: Double = 0.0
    @objc dynamic var latitude: Double = 0.0
    @objc dynamic var like: Int = 0
    @objc dynamic var image: String = ""
    @objc dynamic var favorite: Bool = false
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}
