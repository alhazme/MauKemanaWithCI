//
//  PlacesLocalDataSource.swift
//  
//
//  Created by Moch Fariz Al Hazmi on 03/12/20.
//

import Core
import Combine
import RealmSwift
import Foundation

public struct PlacesLocalDataSource: LocalDataSource {
    
    public typealias Request = String
    public typealias Response = PlaceModuleEntity
    
    private let _realm: Realm
    
    public init(realm: Realm) {
        _realm = realm
    }
    
    public func list(request: String?) -> AnyPublisher<[PlaceModuleEntity], Error> {
        return Future<[PlaceModuleEntity], Error> { completion in
            let places: Results<PlaceModuleEntity> = {
                var data: Results<PlaceModuleEntity> = _realm.objects(PlaceModuleEntity.self)
                if let keyword = request, keyword.count > 0 {
                    data = data
                        .filter("name CONTAINS %@ OR desc CONTAINS %@ OR address CONTAINS %@", keyword, keyword, keyword)
                }
                return data.sorted(
                    byKeyPath: "name",
                    ascending: true
                )
            }()
            completion(.success(places.toArray(ofType: PlaceModuleEntity.self)))
        }.eraseToAnyPublisher()
    }
    
    public func add(entities: [PlaceModuleEntity]) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            do {
                try _realm.write {
                    for place in entities {
                        _realm.add(place, update: .all)
                    }
                    completion(.success(true))
                }
            } catch {
                completion(.failure(DatabaseError.requestFailed))
            }
        }.eraseToAnyPublisher()
    }
    
    public func get(id: String) -> AnyPublisher<PlaceModuleEntity, Error> {
        return Future<PlaceModuleEntity, Error> { completion in
            let placeId: Int = (id as NSString).integerValue
            if let placeDetail = _realm.objects(PlaceModuleEntity.self)
                .filter("id = %@", placeId).first {
                completion(.success(placeDetail))
            } else {
                completion(.failure(DatabaseError.dataNotFound))
            }
        }.eraseToAnyPublisher()
    }
    
    public func update(id: String, entity: PlaceModuleEntity) -> AnyPublisher<PlaceModuleEntity, Error> {
        return Future<PlaceModuleEntity, Error> { completion in
            let placeId: Int = (id as NSString).integerValue
            if let placeDetail = _realm.objects(PlaceModuleEntity.self).filter("id = %@", placeId).first {
                do {
                    try _realm.write {
                        placeDetail.name = entity.name
                        placeDetail.desc = entity.desc
                        placeDetail.address = entity.address
                        placeDetail.longitude = entity.longitude
                        placeDetail.latitude = entity.latitude
                        placeDetail.like = entity.like
                        placeDetail.image = entity.image
                        placeDetail.favorite = entity.favorite
                    }
                    completion(.success(placeDetail))
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.dataNotFound))
            }
        }.eraseToAnyPublisher()
    }
    
    public func favorite(id: String) -> AnyPublisher<PlaceModuleEntity, Error> {
        return Future<PlaceModuleEntity, Error> { completion in
            let placeId: Int = (id as NSString).integerValue
            if let placeDetail = _realm.objects(PlaceModuleEntity.self).filter("id = %@", placeId).first {
                do {
                    try _realm.write {
                        placeDetail.favorite = true
                    }
                    completion(.success(placeDetail))
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.dataNotFound))
            }
        }.eraseToAnyPublisher()
    }
    
    public func unfavorite(id: String) -> AnyPublisher<PlaceModuleEntity, Error> {
        return Future<PlaceModuleEntity, Error> { completion in
            let placeId: Int = (id as NSString).integerValue
            if let placeDetail = _realm.objects(PlaceModuleEntity.self).filter("id = %@", placeId).first {
                do {
                    try _realm.write {
                        placeDetail.favorite = false
                    }
                    completion(.success(placeDetail))
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.dataNotFound))
            }
        }.eraseToAnyPublisher()
    }
}
