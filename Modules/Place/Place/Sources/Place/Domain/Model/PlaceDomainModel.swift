//
//  PlaceDomainModel.swift
//  
//
//  Created by Moch Fariz Al Hazmi on 29/11/20.
//

import Foundation

public struct PlaceDomainModel: Equatable, Identifiable {
    
    public let id: Int
    public let name: String
    public let description: String
    public let address: String
    public let longitude: Double
    public let latitude: Double
    public let like: Int
    public let image: String
    public let favorite: Bool
    
    public init(
        id: Int,
        name: String,
        description: String,
        address: String,
        longitude: Double,
        latitude: Double,
        like: Int,
        image: String,
        favorite: Bool
    ) {
        self.id = id
        self.name = name
        self.description = description
        self.address = address
        self.longitude = longitude
        self.latitude = latitude
        self.like = like
        self.image = image
        self.favorite = favorite
    }
    
}
