//
//  FavoriteUseCase.swift
//  MauKemana
//
//  Created by Moch Fariz Al Hazmi on 02/11/20.
//

import Foundation
import Combine

protocol FavoriteUseCase {
    
    func getFavoritePlaces() -> AnyPublisher<[PlaceModel], Error>
    func searchFavoritePlaces(from keyword: String) -> AnyPublisher<[PlaceModel], Error>
    
}

class FavoriteInteractor: FavoriteUseCase {
    
    private let repository: OldPlacesRepositoryProtocol
    
    required init(repository: OldPlacesRepositoryProtocol) {
        self.repository = repository
    }
    
    func getFavoritePlaces() -> AnyPublisher<[PlaceModel], Error> {
        return repository.getFavoritePlaces()
    }
    
    func searchFavoritePlaces(from keyword: String) -> AnyPublisher<[PlaceModel], Error> {
        return repository.searchFavoritePlaces(from: keyword)
    }
    
}
