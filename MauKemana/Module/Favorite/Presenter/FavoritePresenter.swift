//
//  FavoritePresenter.swift
//  MauKemana
//
//  Created by Moch Fariz Al Hazmi on 02/11/20.
//

import SwiftUI
import Combine

class FavoritePresenter: ObservableObject {
    
    private var cancellables: Set<AnyCancellable> = []
    private let router = FavoriteRouter()
    private let favoriteUseCase: FavoriteUseCase
    
    @Published var places: [PlaceModel] = []
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    @Published var searchText: String = "" {
        didSet {
            if !searchText.isEmpty {
                searchFavoritePlace(from: searchText)
            } else {
                getFavoritePlaces()
            }
        }
    }
    
    init(favoriteUseCase: FavoriteUseCase) {
        self.favoriteUseCase = favoriteUseCase
    }
    
    func getFavoritePlaces() {
        loadingState = true
        favoriteUseCase.getFavoritePlaces()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                case .finished:
                    self.loadingState = false
                }
            }, receiveValue: { places in
                self.places = places
            })
            .store(in: &cancellables)
    }
    
    func searchFavoritePlace(from keyword: String) {
        loadingState = true
        favoriteUseCase.searchFavoritePlaces(from: keyword)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                case .finished:
                    self.loadingState = false
                }
            }, receiveValue: { places in
                self.places = places
            })
            .store(in: &cancellables)
    }
    
//    func linkBuilder<Content: View>(
//        for place: PlaceModel,
//        @ViewBuilder content: () -> Content
//    ) -> some View {
//        NavigationLink(
//            destination: router.makeDetailView(for: place)
//        ) { content() }
//    }
    
}
