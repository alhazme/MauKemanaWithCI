//
//  Injection.swift
//  MauKemana
//
//  Created by Moch Fariz Al Hazmi on 10/11/20.
//

import Foundation
import RealmSwift
import Core
import Place
import UIKit

final class Injection: NSObject {
    
    private func provideRepository() -> OldPlacesRepositoryProtocol {
        let realm = try? Realm()
        let localDataSource: OldPlacesLocalDataSource = OldPlacesLocalDataSource.sharedInstance(realm)
        let remoteDataSource: OldPlacesRemoteDataSource = OldPlacesRemoteDataSource.sharedInstance
        return OldPlacesRepository.sharedInstance(localDataSource, remoteDataSource)
    }
    
    func provideHome() -> HomeUseCase {
        let repository = provideRepository()
        return HomeInteractor(repository: repository)
    }
    
    func provideDetail(place: PlaceModel) -> HomeDetailUseCase {
        let repository = provideRepository()
        return HomeDetailInteractor(repository: repository, place: place)
    }
    
    func provideFavorite() -> FavoriteUseCase {
        let repository = provideRepository()
        return FavoriteInteractor(repository: repository)
    }
    
   func providePlaces<U: UseCase>() -> U where U.Request == String, U.Response == [PlaceDomainModel] {
       
       let appDelegate = UIApplication.shared.delegate as! AppDelegate
       let localDataSource = PlacesLocalDataSource(realm: appDelegate.realm)
       let remoteDataSource = PlacesRemoteDataSource(endpoint: Endpoints.Gets.places.url)
       let mapper = PlaceTransformer()
       let placeRepository = PlacesRepository(
           localDataSource: localDataSource,
           remoteDataSource: remoteDataSource,
           mapper: mapper
       )
       return Interactor(repository: placeRepository) as! U
   }
    
    func providePlace<U: UseCase>() -> U where U.Request == String, U.Response == PlaceDomainModel {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let localDataSource = PlacesLocalDataSource(realm: appDelegate.realm)
        let remoteDataSource = PlacesRemoteDataSource(endpoint: Endpoints.Gets.places.url)
        let mapper = PlaceTransformer()
        let placeRepository = PlaceRepository(
            localDataSource: localDataSource,
            remoteDataSource: remoteDataSource,
            mapper: mapper
        )
        return Interactor(repository: placeRepository) as! U
    }
    
    func provideFavoritePlaces<U: UseCase>() -> U where U.Request == String, U.Response == [PlaceDomainModel] {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let localDataSource = FavoritePlacesLocalDataSource(realm: appDelegate.realm)
        let remoteDataSource = PlacesRemoteDataSource(endpoint: Endpoints.Gets.places.url)
        let mapper = PlaceTransformer()
        let placeRepository = FavoritePlacesRepository(
            localDataSource: localDataSource,
            remoteDataSource: remoteDataSource,
            mapper: mapper
        )
        return Interactor(repository: placeRepository) as! U
    }
    
    func provideFavoritePlace<U: UseCase>() -> U where U.Request == String, U.Response == PlaceDomainModel {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let localDataSource = FavoritePlacesLocalDataSource(realm: appDelegate.realm)
        let remoteDataSource = PlacesRemoteDataSource(endpoint: Endpoints.Gets.places.url)
        let mapper = PlaceTransformer()
        let placeRepository = FavoritePlaceRepository(
            localDataSource: localDataSource,
            remoteDataSource: remoteDataSource,
            mapper: mapper
        )
        return Interactor(repository: placeRepository) as! U
    }
    
    func provideUpdateFavoritePlace<U: UseCase>() -> U where U.Request == String, U.Response == PlaceDomainModel {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let localDataSource = FavoritePlacesLocalDataSource(realm: appDelegate.realm)
        let remoteDataSource = PlacesRemoteDataSource(endpoint: Endpoints.Gets.places.url)
        let mapper = PlaceTransformer()
        let placeRepository = UpdateFavoritePlaceRepository(
            localDataSource: localDataSource,
            remoteDataSource: remoteDataSource,
            mapper: mapper
        )
        return Interactor(repository: placeRepository) as! U
    }
    
    func provideUpdateUnfavoritePlace<U: UseCase>() -> U where U.Request == String, U.Response == PlaceDomainModel {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let localDataSource = FavoritePlacesLocalDataSource(realm: appDelegate.realm)
        let remoteDataSource = PlacesRemoteDataSource(endpoint: Endpoints.Gets.places.url)
        let mapper = PlaceTransformer()
        let placeRepository = UpdateUnfavoritePlaceRepository(
            localDataSource: localDataSource,
            remoteDataSource: remoteDataSource,
            mapper: mapper
        )
        return Interactor(repository: placeRepository) as! U
    }
    
}
