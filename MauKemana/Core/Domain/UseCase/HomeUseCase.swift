//
//  HomeUseCase.swift
//  MauKemana
//
//  Created by Moch Fariz Al Hazmi on 01/11/20.
//

import Foundation
import Combine

protocol HomeUseCase {
    
    func getPlaces() -> AnyPublisher<[PlaceModel], Error>
    func searchPlaces(from keyword: String) -> AnyPublisher<[PlaceModel], Error>
    
}

class HomeInteractor: HomeUseCase {
    
    private let repository: OldPlacesRepositoryProtocol
    
    required init(repository: OldPlacesRepositoryProtocol) {
        self.repository = repository
    }
    
    func getPlaces() -> AnyPublisher<[PlaceModel], Error> {
        return repository.getPlaces()
    }
    
    func searchPlaces(from keyword: String) -> AnyPublisher<[PlaceModel], Error> {
        return repository.searchPlaces(from: keyword)
    }
    
}
