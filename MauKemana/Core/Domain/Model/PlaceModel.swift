//
//  PlaceModel.swift
//  MauKemana
//
//  Created by Moch Fariz Al Hazmi on 01/11/20.
//

import Foundation

struct PlaceModel: Equatable, Identifiable {
    
    let id: Int
    let name: String
    let description: String
    let address: String
    let longitude: Double
    let latitude: Double
    let like: Int
    let image: String
    let favorite: Bool
    
}
