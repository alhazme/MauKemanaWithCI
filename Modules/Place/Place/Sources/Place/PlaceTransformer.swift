//
//  PlaceTransformer.swift
//  
//
//  Created by Moch Fariz Al Hazmi on 29/11/20.
//

import Foundation
import Core

public struct PlaceTransformer: Mapper {
    
    public typealias Response = PlaceResponse
    public typealias Entity = PlaceModuleEntity
    public typealias Domain = PlaceDomainModel
    
    public init() {}
    
    public func transformResponsesToDomains(responses: [PlaceResponse]) -> [PlaceDomainModel] {
        return responses.map { response in
            return PlaceDomainModel(
                id: response.id,
                name: response.name,
                description: response.description,
                address: response.address,
                longitude: response.longitude,
                latitude: response.latitude,
                like: response.like,
                image: response.image,
                favorite: false
            )
        }
    }
    
    public func transformResponsesToEntities(responses: [PlaceResponse]) -> [PlaceModuleEntity] {
        return responses.map { response in
            let placeModuleEntity = PlaceModuleEntity()
            placeModuleEntity.id = response.id
            placeModuleEntity.name = response.name
            placeModuleEntity.desc = response.description
            placeModuleEntity.address = response.address
            placeModuleEntity.longitude = response.longitude
            placeModuleEntity.latitude = response.latitude
            placeModuleEntity.like = response.like
            placeModuleEntity.image = response.image
            placeModuleEntity.favorite = false
            return placeModuleEntity
        }
    }
    
    public func transformEntitiesToDomains(entities: [PlaceModuleEntity]) -> [PlaceDomainModel] {
        return entities.map { entity in
            return PlaceDomainModel(
                id: entity.id,
                name: entity.name,
                description: entity.desc,
                address: entity.address,
                longitude: entity.longitude,
                latitude: entity.latitude,
                like: entity.like,
                image: entity.image,
                favorite: entity.favorite
            )
        }
    }
    
    public func transformDomainsToEntities(domains: [PlaceDomainModel]) -> [PlaceModuleEntity] {
        return domains.map { domain in
            let placeModuleEntity = PlaceModuleEntity()
            placeModuleEntity.id = domain.id
            placeModuleEntity.name = domain.name
            placeModuleEntity.desc = domain.description
            placeModuleEntity.address = domain.address
            placeModuleEntity.longitude = domain.longitude
            placeModuleEntity.latitude = domain.latitude
            placeModuleEntity.like = domain.like
            placeModuleEntity.image = domain.image
            placeModuleEntity.favorite = domain.favorite
            return placeModuleEntity
        }
    }
    
    public func transformEntityToDomain(entity: PlaceModuleEntity) -> PlaceDomainModel {
        return PlaceDomainModel(
            id: entity.id,
            name: entity.name,
            description: entity.desc,
            address: entity.address,
            longitude: entity.longitude,
            latitude: entity.latitude,
            like: entity.like,
            image: entity.image,
            favorite: entity.favorite
        )
    }
    
    public func transformDomainToEntity(domain: PlaceDomainModel) -> PlaceModuleEntity {
        let placeModuleEntity = PlaceModuleEntity()
        placeModuleEntity.id = domain.id
        placeModuleEntity.name = domain.name
        placeModuleEntity.desc = domain.description
        placeModuleEntity.address = domain.address
        placeModuleEntity.longitude = domain.longitude
        placeModuleEntity.latitude = domain.latitude
        placeModuleEntity.like = domain.like
        placeModuleEntity.image = domain.image
        placeModuleEntity.favorite = domain.favorite
        return placeModuleEntity
    }
    
    /*
    public func transformResponsesToDomains(
        responses: [PlaceResponse]
    ) -> [PlaceDomainModel] {
        return responses.map { response in
            return PlaceDomainModel(
                id: response.id,
                name: response.name,
                description: response.description,
                address: response.address,
                longitude: response.longitude,
                latitude: response.latitude,
                like: response.like,
                image: response.image,
                favorite: false
            )
        }
    }
    
    public func transformResponsesToEntities(
        responses: [PlaceResponse]
    ) -> [PlaceModuleEntity] {
        return responses.map { response in
            return transformResponseToEntity(response: response)
        }
    }
    
    public func transformEntitiesToDomains(
        entities: [PlaceModuleEntity]
    ) -> [PlaceDomainModel] {
        return entities.map { entity in
            return transformEntityToDomain(entity: entity)
        }
    }
    
    public func transformResponseToEntity(
        response: PlaceResponse
    ) -> PlaceModuleEntity {
        let placeModuleEntity = PlaceModuleEntity()
        placeModuleEntity.id = response.id
        placeModuleEntity.name = response.name
        placeModuleEntity.desc = response.description
        placeModuleEntity.address = response.address
        placeModuleEntity.longitude = response.longitude
        placeModuleEntity.latitude = response.latitude
        placeModuleEntity.like = response.like
        placeModuleEntity.image = response.image
        placeModuleEntity.favorite = false
        return placeModuleEntity
    }
    
    public func transformEntityToDomain(entity: PlaceModuleEntity) -> PlaceDomainModel {
        return PlaceDomainModel(
            id: entity.id,
            name: entity.name,
            description: entity.desc,
            address: entity.address,
            longitude: entity.longitude,
            latitude: entity.latitude,
            like: entity.like,
            image: entity.image,
            favorite: entity.favorite
        )
    }
    
    public func transformDomainToEntity(domain: PlaceDomainModel) -> PlaceModuleEntity {
        let placeModuleEntity = PlaceModuleEntity()
        placeModuleEntity.id = domain.id
        placeModuleEntity.name = domain.name
        placeModuleEntity.desc = domain.description
        placeModuleEntity.address = domain.address
        placeModuleEntity.longitude = domain.longitude
        placeModuleEntity.latitude = domain.latitude
        placeModuleEntity.like = domain.like
        placeModuleEntity.image = domain.image
        placeModuleEntity.favorite = domain.favorite
        return placeModuleEntity
    }
 */
}
