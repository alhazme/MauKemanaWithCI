//
//  FavoriteRouter.swift
//  MauKemana
//
//  Created by Moch Fariz Al Hazmi on 13/11/20.
//

import SwiftUI
import Core
import Place

class FavoriteRouter {
    
    func makeDetailView(for place: PlaceDomainModel) -> some View {
        
        let detailUseCase: Interactor<
            String,
            PlaceDomainModel,
            PlaceRepository<
                PlacesLocalDataSource,
                PlacesRemoteDataSource,
                PlaceTransformer
            >
        > = Injection.init().providePlace()
        
        let updateFavoriteUseCase: Interactor<
            String,
            PlaceDomainModel,
            UpdateFavoritePlaceRepository<
                FavoritePlacesLocalDataSource,
                PlacesRemoteDataSource,
                PlaceTransformer
            >
        > = Injection.init().provideUpdateFavoritePlace()
        
        let updateUnfavoriteUseCase: Interactor<
            String,
            PlaceDomainModel,
            UpdateUnfavoritePlaceRepository<
                FavoritePlacesLocalDataSource,
                PlacesRemoteDataSource,
                PlaceTransformer
            >
        > = Injection.init().provideUpdateUnfavoritePlace()
        
        let detailPresenter = PlacePresenter(
            detailUseCase: detailUseCase,
            favoriteUseCase: updateFavoriteUseCase,
            unfavoriteUseCase: updateUnfavoriteUseCase
        )
        
        return HomeDetailView(detailPresenter: detailPresenter, place: place)
        
        /*
        let useCase: Interactor<
            String,
            PlaceDomainModel,
            PlaceRepository<
                PlacesLocalDataSource,
                PlacesRemoteDataSource,
                PlaceTransformer
            >
        > = Injection.init().providePlace()
        let presenter = Presenter(useCase: useCase)
        
        let updateFavoriteUseCase: Interactor<
            String,
            PlaceDomainModel,
            UpdateFavoritePlaceRepository<
                FavoritePlacesLocalDataSource,
                PlacesRemoteDataSource,
                PlaceTransformer
            >
        > = Injection.init().provideUpdateFavoritePlace()
        let updateFavoritePresenter = UpdatePresenter(useCase: updateFavoriteUseCase)
        
        let updateUnfavoriteUseCase: Interactor<
            String,
            PlaceDomainModel,
            UpdateUnfavoritePlaceRepository<
                FavoritePlacesLocalDataSource,
                PlacesRemoteDataSource,
                PlaceTransformer
            >
        > = Injection.init().provideUpdateUnfavoritePlace()
        let updateUnfavoritePresenter = UpdatePresenter(useCase: updateUnfavoriteUseCase)
        
        return HomeDetailView(
            presenter: presenter,
            updateFavoritePresenter: updateFavoritePresenter,
            updateUnfavoritePresenter: updateUnfavoritePresenter,
            place: place
        )
         */
    }
  
}
