//
//  File.swift
//  
//
//  Created by Moch Fariz Al Hazmi on 29/11/20.
//

import Foundation
import Combine
 
public protocol RemoteDataSource {
    
    associatedtype Request
    associatedtype Response
    
    func execute(request: Request?) -> AnyPublisher<Response, Error>
}
