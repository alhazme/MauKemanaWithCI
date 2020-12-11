//
//  PlacesRepository.swift
//  MauKemana
//
//  Created by Moch Fariz Al Hazmi on 01/11/20.
//

import Foundation
import Combine

protocol OldPlacesRepositoryProtocol {
    
    func getPlaces() -> AnyPublisher<[PlaceModel], Error>
    func getFavoritePlaces() -> AnyPublisher<[PlaceModel], Error>
    func setFavoritePlace(from placeId: Int) -> AnyPublisher<PlaceModel, Error>
    func setUnfavoritePlace(from placeId: Int) -> AnyPublisher<PlaceModel, Error>
    func searchPlaces(from keyword: String) -> AnyPublisher<[PlaceModel], Error>
    func searchFavoritePlaces(from keyword: String) -> AnyPublisher<[PlaceModel], Error>
}

final class OldPlacesRepository: NSObject {
    
    typealias PlacesInstance = (OldPlacesLocalDataSource, OldPlacesRemoteDataSource) -> OldPlacesRepository
    
    fileprivate let remote: OldPlacesRemoteDataSource
    fileprivate let local: OldPlacesLocalDataSource
    
    private init(local: OldPlacesLocalDataSource, remote: OldPlacesRemoteDataSource) {
        self.local = local
        self.remote = remote
    }
    
    static let sharedInstance: PlacesInstance = { localRepository, remoteRepository in
        return OldPlacesRepository(local: localRepository, remote: remoteRepository)
    }
    
}

extension OldPlacesRepository: OldPlacesRepositoryProtocol {
    
    func getPlaces() -> AnyPublisher<[PlaceModel], Error> {
        return self.local.getPlaces()
            .flatMap { placeEntities -> AnyPublisher<[PlaceModel], Error> in
                if placeEntities.isEmpty {
                    print("placeEntities.isEmpty")
                    return self.remote.getPlaces()
                        .map {
                            OldPlaceMapper.mapPlaceResponsesToEntities(input: $0)
                        }
                        .flatMap {
                            self.local.addPlaces(from: $0)
                        }
                        .filter { $0 }
                        .flatMap { _ in
                            self.local.getPlaces()
                                .map {
                                    OldPlaceMapper.mapPlaceEntitiesToModel(input: $0)
                                }
                        }
                        .eraseToAnyPublisher()
                } else {
                    print("placeEntities.notEmpty")
                    return self.local.getPlaces()
                        .map {
                            OldPlaceMapper.mapPlaceEntitiesToModel(input: $0)
                        }
                        .eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
    
    func getFavoritePlaces() -> AnyPublisher<[PlaceModel], Error> {
        return self.local.getFavoritePlaces().map {
            OldPlaceMapper.mapPlaceEntitiesToModel(input: $0)
        }.eraseToAnyPublisher()
    }
    
    func searchPlaces(from keyword: String) -> AnyPublisher<[PlaceModel], Error> {
        return self.local.searchPlaces(from: keyword).map {
            OldPlaceMapper.mapPlaceEntitiesToModel(input: $0)
        }.eraseToAnyPublisher()
    }
    
    func searchFavoritePlaces(from keyword: String) -> AnyPublisher<[PlaceModel], Error> {
        return self.local.searchFavoritePlaces(from: keyword).map {
            OldPlaceMapper.mapPlaceEntitiesToModel(input: $0)
        }.eraseToAnyPublisher()
    }
    
    func setFavoritePlace(from placeId: Int) -> AnyPublisher<PlaceModel, Error> {
        return self.local.setFavoritePlace(from: placeId).map {
            OldPlaceMapper.placeEntityToModel(input: $0)
        }.eraseToAnyPublisher()
    }
    
    func setUnfavoritePlace(from placeId: Int) -> AnyPublisher<PlaceModel, Error> {
        return self.local.setUnfavoritePlace(from: placeId).map {
            OldPlaceMapper.placeEntityToModel(input: $0)
        }.eraseToAnyPublisher()
    }
    
}
