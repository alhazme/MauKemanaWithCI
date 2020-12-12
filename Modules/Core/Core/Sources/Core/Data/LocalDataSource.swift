//
//  File.swift
//  
//
//  Created by Moch Fariz Al Hazmi on 22/11/20.
//

import Foundation
import Combine

public protocol LocalDataSource {
    
    associatedtype Request
    associatedtype Response
    
    func list(request: Request?) -> AnyPublisher<[Response], Error>
    func add(entities: [Response]) -> AnyPublisher<Bool, Error>
    func get(id: Request) -> AnyPublisher<Response, Error>
    func update(id: Request, entity: Response) -> AnyPublisher<Response, Error>
    func favorite(id: Request) -> AnyPublisher<Response, Error>
    func unfavorite(id: Request) -> AnyPublisher<Response, Error>
}
