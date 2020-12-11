//
//  HomeDetailPresenter.swift
//  MauKemana
//
//  Created by Moch Fariz Al Hazmi on 11/11/20.
//

import SwiftUI
import Combine

class HomeDetailPresenter: ObservableObject {
    
    private let homeDetailUseCase: HomeDetailUseCase
    private var cancellables: Set<AnyCancellable> = []

    @Published var place: PlaceModel
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    
    init(homeDetailUseCase: HomeDetailUseCase) {
        self.homeDetailUseCase = homeDetailUseCase
        place = homeDetailUseCase.getPlace()
    }
    
    func setFavoritePlace() {
        loadingState = true
        homeDetailUseCase.setFavorite(place)
            .sink { [weak self] (completion) in
                guard let ws = self else { return }
                switch completion {
                case .failure:
                    ws.errorMessage = String(describing: completion)
                case .finished:
                    ws.loadingState = false
                }
            } receiveValue: { [weak self] (place) in
                guard let ws = self else { return }
                ws.place = place
            }
            .store(in: &cancellables)
    }
    
    func setUnfavoritePlace() {
        loadingState = true
        homeDetailUseCase.setUnfavorite(place)
            .sink { [weak self] (completion) in
                guard let ws = self else { return }
                switch completion {
                case .failure:
                    ws.errorMessage = String(describing: completion)
                case .finished:
                    ws.loadingState = false
                }
            } receiveValue: { [weak self] (place) in
                guard let ws = self else { return }
                ws.place = place
            }
            .store(in: &cancellables)
    }

}
