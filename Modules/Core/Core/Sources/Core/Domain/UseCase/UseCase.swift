//
//  File.swift
//  
//
//  Created by Moch Fariz Al Hazmi on 22/11/20.
//

import Foundation
import Combine

public protocol UseCase {
    
    associatedtype Request
    associatedtype Response
    
    func execute(request: Request?) -> AnyPublisher<Response, Error>
}
