//
//  PlacesRemoteDataSource.swift
//  
//
//  Created by Moch Fariz Al Hazmi on 03/12/20.
//

import Core
import Combine
import Alamofire
import Foundation

public struct PlacesRemoteDataSource: RemoteDataSource {
    
    public typealias Request = Any
    public typealias Response = [PlaceResponse]
    
    private let _endpoint: String
    
    public init(endpoint: String) {
        _endpoint = endpoint
    }
    
    public func execute(request: Any?) -> AnyPublisher<[PlaceResponse], Error> {
        return Future<[PlaceResponse], Error> { completion in
            if let url = URL(string: _endpoint) {
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
