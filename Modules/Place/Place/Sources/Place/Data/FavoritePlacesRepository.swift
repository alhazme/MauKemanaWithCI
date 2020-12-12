//
//  FavoritePlacesRepository.swift
//  
//
//  Created by Moch Fariz Al Hazmi on 03/12/20.
//

import Core
import Combine

public struct FavoritePlacesRepository<
    FavoritePlacesLocalDataSource: LocalDataSource,
    PlacesRemoteDataSource: RemoteDataSource,
    Transformer: Mapper
>: Repository where
    FavoritePlacesLocalDataSource.Request == String,
    FavoritePlacesLocalDataSource.Response == PlaceModuleEntity,
    PlacesRemoteDataSource.Response == [PlaceResponse],
    Transformer.Response == PlaceResponse,
    Transformer.Entity == PlaceModuleEntity,
    Transformer.Domain == PlaceDomainModel {
    
    public typealias Request = String
    public typealias Response = [PlaceDomainModel]
    
    private let _localDataSource: FavoritePlacesLocalDataSource
    private let _remoteDataSource: PlacesRemoteDataSource
    private let _mapper: Transformer
    
    public init(
        localDataSource: FavoritePlacesLocalDataSource,
        remoteDataSource: PlacesRemoteDataSource,
        mapper: Transformer
    ) {
        _localDataSource = localDataSource
        _remoteDataSource = remoteDataSource
        _mapper = mapper
    }
    
    public func execute(
        request: String?
    ) -> AnyPublisher<[PlaceDomainModel], Error> {
        return _localDataSource.list(request: request)
            .map {
                _mapper.transformEntitiesToDomains(entities: $0)
            }
            .eraseToAnyPublisher()
    }
}
