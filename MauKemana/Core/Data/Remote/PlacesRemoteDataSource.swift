//
//  PlacesRemoteDataSource.swift
//  MauKemana
//
//  Created by Moch Fariz Al Hazmi on 01/11/20.
//

import Foundation
import Alamofire
import Combine

protocol OldPlacesRemoteDataSourceProtocol: class {
    
    func getPlaces() -> AnyPublisher<[PlaceResponse], Error>
    
}

final class OldPlacesRemoteDataSource: NSObject {
    
    private override init() { }
    
    static let sharedInstance: OldPlacesRemoteDataSource = OldPlacesRemoteDataSource()
    
}

extension OldPlacesRemoteDataSource: OldPlacesRemoteDataSourceProtocol {
    
    func getPlaces() -> AnyPublisher<[PlaceResponse], Error> {
        return Future<[PlaceResponse], Error> { completion in
            if let url = URL(string: Endpoints.Gets.places.url) {
                AF.request(url)
                    .validate()
                    .responseDecodable(of: PlacesResponse.self) { (response) in
                        switch response.result {
                        case .success(let response):
                            completion(.success(response.places))
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }
            }
        }.eraseToAnyPublisher()
    }
    
}
