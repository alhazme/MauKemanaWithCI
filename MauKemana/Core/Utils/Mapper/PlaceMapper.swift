//
//  PlaceMapper.swift
//  MauKemana
//
//  Created by Moch Fariz Al Hazmi on 01/11/20.
//

final class OldPlaceMapper {
    
    static func mapPlaceResponsesToModel(
        input placeResponses: [PlaceResponse]
    ) -> [PlaceModel] {
        return placeResponses.map { placeResponse in
            return PlaceModel(
                id: placeResponse.id,
                name: placeResponse.name,
                description: placeResponse.description,
                address: placeResponse.address,
                longitude: placeResponse.longitude,
                latitude: placeResponse.latitude,
                like: placeResponse.like,
                image: placeResponse.image,
                favorite: false
            )
        }
    }
    
    static func mapPlaceResponsesToEntities(
        input placeResponses: [PlaceResponse]
    ) -> [PlaceEntity] {
        return placeResponses.map { placeResponse in
            let placeEntity = PlaceEntity()
            placeEntity.id = placeResponse.id
            placeEntity.name = placeResponse.name
            placeEntity.desc = placeResponse.description
            placeEntity.address = placeResponse.address
            placeEntity.longitude = placeResponse.longitude
            placeEntity.latitude = placeResponse.latitude
            placeEntity.like = placeResponse.like
            placeEntity.image = placeResponse.image
            placeEntity.favorite = false
            return placeEntity
        }
    }
    
    static func mapPlaceEntitiesToModel(
        input placeEntities: [PlaceEntity]
    ) -> [PlaceModel] {
        return placeEntities.map { placeEntity in
            return PlaceModel(
                id: placeEntity.id,
                name: placeEntity.name,
                description: placeEntity.desc,
                address: placeEntity.address,
                longitude: placeEntity.longitude,
                latitude: placeEntity.latitude,
                like: placeEntity.like,
                image: placeEntity.image,
                favorite: placeEntity.favorite
            )
        }
    }
    
    static func placeEntityToModel(
        input placeEntity: PlaceEntity
    ) -> PlaceModel {
        return PlaceModel(
            id: placeEntity.id,
            name: placeEntity.name,
            description: placeEntity.desc,
            address: placeEntity.address,
            longitude: placeEntity.longitude,
            latitude: placeEntity.latitude,
            like: placeEntity.like,
            image: placeEntity.image,
            favorite: placeEntity.favorite
        )
    }
    
    static func placeModelToEntity(
        input placeModel: PlaceModel
    ) -> PlaceEntity {
        let placeEntity = PlaceEntity()
        placeEntity.id = placeModel.id
        placeEntity.name = placeModel.name
        placeEntity.desc = placeModel.description
        placeEntity.address = placeModel.address
        placeEntity.longitude = placeModel.longitude
        placeEntity.latitude = placeModel.latitude
        placeEntity.like = placeModel.like
        placeEntity.image = placeModel.image
        placeEntity.favorite = placeModel.favorite
        return placeEntity
    }
    
}
