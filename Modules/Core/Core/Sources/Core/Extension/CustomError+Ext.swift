//
//  CustomError+Ext.swift
//  
//
//  Created by Moch Fariz Al Hazmi on 28/11/20.
//

import Foundation

public enum URLError: LocalizedError {

    case invalidResponse
    case addressUnreachable(URL)
  
    public var errorDescription: String? {
        switch self {
        case .invalidResponse: return "The server responded with garbage."
        case .addressUnreachable(let url): return "\(url.absoluteString) is unreachable."
        }
    }

}

public enum DatabaseError: LocalizedError {

    case invalidInstance
    case requestFailed
    case dataNotFound
  
    public var errorDescription: String? {
        switch self {
        case .invalidInstance: return "Database can't instance."
        case .requestFailed: return "Your request failed."
        case .dataNotFound: return "Data not found"
        }
    }

}

public struct RequestParameter {
    
    public let keyword: String
    public let favorite: Bool
    
    public init(keyword: String, favorite: Bool) {
        self.keyword = keyword
        self.favorite = favorite
    }
}
