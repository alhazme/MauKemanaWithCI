//
//  PlacesLocalDataSource.swift
//  MauKemana
//
//  Created by Moch Fariz Al Hazmi on 01/11/20.
//

import Foundation
import RealmSwift
import Combine

protocol OldPlacesLocalDataSourceProtocol: class {
    
    func getPlaces() -> AnyPublisher<[PlaceEntity], Error>
    func addPlaces(from places: [PlaceEntity]) -> AnyPublisher<Bool, Error>
    func setFavoritePlace(from placeId: Int) -> AnyPublisher<PlaceEntity, Error>
    func setUnfavoritePlace(from placeId: Int) -> AnyPublisher<PlaceEntity, Error>
    func getFavoritePlaces() -> AnyPublisher<[PlaceEntity], Error>
    func searchPlaces(from keyword: String) -> AnyPublisher<[PlaceEntity], Error>
    func searchFavoritePlaces(from keyword: String) -> AnyPublisher<[PlaceEntity], Error>
    
}

final class OldPlacesLocalDataSource {
    
    private let realm: Realm?
    private init(realm: Realm?) {
        self.realm = realm
    }
    
    static let sharedInstance: (Realm?) -> OldPlacesLocalDataSource = { realmDatabase in
        return OldPlacesLocalDataSource(realm: realmDatabase)
    }
    
}

extension OldPlacesLocalDataSource: OldPlacesLocalDataSourceProtocol {
    
    func getPlaces() -> AnyPublisher<[PlaceEntity], Error> {
        return Future<[PlaceEntity], Error> { [weak self] completion in
            guard let ws = self else { return }
            if let realm = ws.realm {
                let places: Results<PlaceEntity> = {
                    realm.objects(PlaceEntity.self)
                        .sorted(
                            byKeyPath: "name",
                            ascending: true
                        )
                }()
                completion(.success(places.toArray(ofType: PlaceEntity.self)))
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func addPlaces(from places: [PlaceEntity]) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { [weak self] completion in
            guard let ws = self else { return }
            if let realm = ws.realm {
                do {
                    try realm.write {
                        for place in places {
                            realm.add(place, update: .all)
                        }
                        completion(.success(true))
                    }
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func setFavoritePlace(from placeId: Int) -> AnyPublisher<PlaceEntity, Error> {
        return Future<PlaceEntity, Error> { [weak self] completion in
            guard let ws = self else { return }
            if let realm = ws.realm {
                if let placeDetail = realm.objects(PlaceEntity.self).filter("id = %@", placeId).first {
                    do {
                        try realm.write {
                            placeDetail.favorite = true
                        }
                        completion(.success(placeDetail))
                    } catch {
                        completion(.failure(DatabaseError.requestFailed))
                    }
                } else {
                    completion(.failure(DatabaseError.dataNotFound))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func setUnfavoritePlace(from placeId: Int) -> AnyPublisher<PlaceEntity, Error> {
        return Future<PlaceEntity, Error> { [weak self] completion in
            guard let ws = self else { return }
            if let realm = ws.realm {
                if let placeDetail = realm.objects(PlaceEntity.self).filter("id = %@", placeId).first {
                    do {
                        try realm.write {
                            placeDetail.favorite = false
                        }
                        completion(.success(placeDetail))
                    } catch {
                        completion(.failure(DatabaseError.requestFailed))
                    }
                } else {
                    completion(.failure(DatabaseError.dataNotFound))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func getFavoritePlaces() -> AnyPublisher<[PlaceEntity], Error> {
        return Future<[PlaceEntity], Error> { [weak self] completion in
            guard let ws = self else { return }
            if let realm = ws.realm {
                let places: Results<PlaceEntity> = {
                    realm.objects(PlaceEntity.self)
                        .filter("favorite = %@", true)
                        .sorted(
                            byKeyPath: "name",
                            ascending: true
                        )
                }()
                completion(.success(places.toArray(ofType: PlaceEntity.self)))
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func searchPlaces(from keyword: String) -> AnyPublisher<[PlaceEntity], Error> {
        return Future<[PlaceEntity], Error> { [weak self] completion in
            guard let ws = self else { return }
            if let realm = ws.realm {
                let places: Results<PlaceEntity> = {
                    realm.objects(PlaceEntity.self)
                        .filter("name CONTAINS %@ OR desc CONTAINS %@ OR address CONTAINS %@", keyword, keyword, keyword)
                        .sorted(
                            byKeyPath: "name",
                            ascending: true
                        )
                }()
                completion(.success(places.toArray(ofType: PlaceEntity.self)))
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func searchFavoritePlaces(from keyword: String) -> AnyPublisher<[PlaceEntity], Error> {
        return Future<[PlaceEntity], Error> { [weak self] completion in
            guard let ws = self else { return }
            if let realm = ws.realm {
                let places: Results<PlaceEntity> = {
                    realm.objects(PlaceEntity.self)
                        .filter("(name CONTAINS %@ OR desc CONTAINS %@ OR address CONTAINS %@) AND favorite == %@", keyword, keyword, keyword, true)
                        .sorted(
                            byKeyPath: "name",
                            ascending: true
                        )
                }()
                completion(.success(places.toArray(ofType: PlaceEntity.self)))
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
}
