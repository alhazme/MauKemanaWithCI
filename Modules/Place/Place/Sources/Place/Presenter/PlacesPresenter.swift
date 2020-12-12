//
//  File.swift
//  
//
//  Created by Moch Fariz Al Hazmi on 05/12/20.
//

import Foundation
import Combine
import Core

public class PlacesPresenter<ListUseCase: UseCase, SearchUseCase: UseCase> : ObservableObject
where
    ListUseCase.Request == String, ListUseCase.Response == [PlaceDomainModel],
    SearchUseCase.Request == String, SearchUseCase.Response == [PlaceDomainModel] {
    
    private var cancellables: Set<AnyCancellable> = []
    
    private let _listUseCase: ListUseCase
    private let _searchUseCase: SearchUseCase
    
    @Published public var list: [PlaceDomainModel] = []
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isError: Bool = false
    
    public init(listUseCase: ListUseCase, searchUseCase: SearchUseCase) {
        _listUseCase = listUseCase
        _searchUseCase = searchUseCase
    }
    
    public func load() {
        isLoading = true
        _listUseCase.execute(request: nil)
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
            }, receiveValue: { [weak self] list in
                guard let ws = self else { return }
                ws.list = list
            })
            .store(in: &cancellables)
    }
    
    public func search(keyword: SearchUseCase.Request) {
        isLoading = true
        _searchUseCase.execute(request: keyword)
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
            }, receiveValue: { list in
                self.list = list
            })
            .store(in: &cancellables)
    }
    
}
