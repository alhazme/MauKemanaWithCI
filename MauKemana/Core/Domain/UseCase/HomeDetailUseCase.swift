//
//  HomeDetailUseCase.swift
//  MauKemana
//
//  Created by Moch Fariz Al Hazmi on 02/11/20.
//

import Foundation
import Combine

protocol HomeDetailUseCase {
    
    func getPlace() -> PlaceModel
    func setFavorite(_ place: PlaceModel) -> AnyPublisher<PlaceModel, Error>
    func setUnfavorite(_ place: PlaceModel) -> AnyPublisher<PlaceModel, Error>
    
}

class HomeDetailInteractor: HomeDetailUseCase {
    
    private let repository: OldPlacesRepositoryProtocol
    private let place: PlaceModel
    
    required init(
        repository: OldPlacesRepositoryProtocol,
        place: PlaceModel
    ) {
        self.repository = repository
        self.place = place
    }
    
    func getPlace() -> PlaceModel {
        return place
    }
    
    func setFavorite(_ place: PlaceModel) -> AnyPublisher<PlaceModel, Error> {
        return repository.setFavoritePlace(from: place.id)
    }
    
    func setUnfavorite(_ place: PlaceModel) -> AnyPublisher<PlaceModel, Error> {
        return repository.setUnfavoritePlace(from: place.id)
    }

}
