//
//  File.swift
//  
//
//  Created by Moch Fariz Al Hazmi on 05/12/20.
//

import Foundation
import Combine
import Core

public class PlacePresenter<DetailUseCase: UseCase, FavoriteUseCase: UseCase, UnfavoriteUseCase: UseCase> : ObservableObject
where
    DetailUseCase.Request == String, DetailUseCase.Response == PlaceDomainModel,
    FavoriteUseCase.Request == String, FavoriteUseCase.Response == PlaceDomainModel,
    UnfavoriteUseCase.Request == String, UnfavoriteUseCase.Response == PlaceDomainModel {
    
    private var cancellables: Set<AnyCancellable> = []
    
    private let _detailUseCase: DetailUseCase
    private let _favoriteUseCase: FavoriteUseCase
    private let _unfavoriteUseCase: UnfavoriteUseCase
    
    @Published public var item: PlaceDomainModel?
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isError: Bool = false
    
    public init(
        detailUseCase: DetailUseCase,
        favoriteUseCase: FavoriteUseCase,
        unfavoriteUseCase: UnfavoriteUseCase
    ) {
        _detailUseCase = detailUseCase
        _favoriteUseCase = favoriteUseCase
        _unfavoriteUseCase = unfavoriteUseCase
    }
    
    public func getDetail(request: DetailUseCase.Request) {
        isLoading = true
        _detailUseCase.execute(request: request)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.isError = true
                    self.isLoading = false
                case .finished:
                    self.isLoading = false
                }
            }, receiveValue: { item in
                self.item = item
            })
            .store(in: &cancellables)
    }
    
    public func setToFavorite(request: FavoriteUseCase.Request) {
        _favoriteUseCase.execute(request: request)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.isError = true
                    self.isLoading = false
                case .finished:
                    self.isLoading = false
                }
            }, receiveValue: { item in
                self.item = item
            })
            .store(in: &cancellables)
    }
    
    public func setToUnfavorite(request: UnfavoriteUseCase.Request) {
        _unfavoriteUseCase.execute(request: request)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.isError = true
                    self.isLoading = false
                case .finished:
                    self.isLoading = false
                }
            }, receiveValue: { item in
                self.item = item
            })
            .store(in: &cancellables)
    }
    
}
