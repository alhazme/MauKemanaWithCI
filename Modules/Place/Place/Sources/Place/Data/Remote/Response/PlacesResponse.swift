//
//  PlacesResponse.swift
//  
//
//  Created by Moch Fariz Al Hazmi on 29/11/20.
//

import Foundation

public struct PlacesResponse: Decodable {
    
    let error: Bool
    let message: String
    let count: Int
    let places: [PlaceResponse]
    
}

public struct PlaceResponse: Decodable {
    
    let id: Int
    let name: String
    let description: String
    let address: String
    let longitude: Double
    let latitude: Double
    let like: Int
    let image: String
}
