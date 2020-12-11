//
//  PlacesResponse.swift
//  MauKemana
//
//  Created by Moch Fariz Al Hazmi on 01/11/20.
//

import Foundation

struct PlacesResponse: Decodable {
    
    let error: Bool
    let message: String
    let count: Int
    let places: [PlaceResponse]
    
}

struct PlaceResponse: Decodable {
    
    let id: Int
    let name: String
    let description: String
    let address: String
    let longitude: Double
    let latitude: Double
    let like: Int
    let image: String
}
