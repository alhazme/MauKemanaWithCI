//
//  Mapper.swift
//  
//
//  Created by Moch Fariz Al Hazmi on 28/11/20.
//

import Foundation

public protocol Mapper {
    
    associatedtype Response
    associatedtype Entity
    associatedtype Domain
    
    // responsesToModels
    func transformResponsesToDomains(responses: [Response]) -> [Domain]
    // responsesToEntities
    func transformResponsesToEntities(responses: [Response]) -> [Entity]
    // entitiesToDomains
    func transformEntitiesToDomains(entities: [Entity]) -> [Domain]
    // placeModelToEntity
    func transformDomainsToEntities(domains: [Domain]) -> [Entity]
    
    // entityToPlaceModel
    func transformEntityToDomain(entity: Entity) -> Domain
    // placeModelToEntity
    func transformDomainToEntity(domain: Domain) -> Entity
}
