//
//  APICall.swift
//  MauKemana
//
//  Created by Moch Fariz Al Hazmi on 01/11/20.
//

import Foundation

struct API {
    
    static let baseURL = "https://tourism-api.dicoding.dev"
    
}

protocol Endpoint {

  var url: String { get }

}

enum Endpoints {
  
  enum Gets: Endpoint {
    case places
    
    public var url: String {
      switch self {
      case .places: return "\(API.baseURL)/list"
      }
    }
  }
  
}
