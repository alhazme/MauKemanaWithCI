//
//  HomePresenter.swift
//  MauKemana
//
//  Created by Moch Fariz Al Hazmi on 02/11/20.
//

import SwiftUI
import Combine
import Core
import Place

class HomePresenter: ObservableObject {
    
    private var cancellables: Set<AnyCancellable> = []
    private let router = HomeRouter()
    private let homeUseCase: HomeUseCase
    
    @Published var places: [PlaceModel] = []
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    @Published var searchText: String = "" {
        didSet {
            if !searchText.isEmpty {
                searchPlace(from: searchText)
            } else {
                getPlaces()
            }
        }
    }
    
    init(homeUseCase: HomeUseCase) {
        self.homeUseCase = homeUseCase
    }
    
    func getPlaces() {
        loadingState = true
        homeUseCase.getPlaces()
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
    
    func searchPlace(from keyword: String) {
        loadingState = true
        homeUseCase.searchPlaces(from: keyword)
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
    
    func linkBuilder<Content: View>(
        for place: PlaceDomainModel,
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(
            destination: router.makeDetailView(for: place)
        ) { content() }
    }
    
}
