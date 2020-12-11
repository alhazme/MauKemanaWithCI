//
//  ContentView.swift
//  MauKemana
//
//  Created by Moch Fariz Al Hazmi on 31/10/20.
//

import SwiftUI
import Core
import Place

struct ContentView: View {
    
    @EnvironmentObject var homePresenter: PlacesPresenter<
        Interactor<
            String,
            [PlaceDomainModel],
            PlacesRepository<
                PlacesLocalDataSource,
                PlacesRemoteDataSource,
                PlaceTransformer
            >
        >,
        Interactor<
            String,
            [PlaceDomainModel],
            PlacesRepository<
                PlacesLocalDataSource,
                PlacesRemoteDataSource,
                PlaceTransformer
            >
        >
    >
    
    @EnvironmentObject var favoritePresenter: PlacesPresenter<
        Interactor<
            String,
            [PlaceDomainModel],
            FavoritePlacesRepository<
                FavoritePlacesLocalDataSource,
                PlacesRemoteDataSource,
                PlaceTransformer
            >
        >,
        Interactor<
            String,
            [PlaceDomainModel],
            FavoritePlacesRepository<
                FavoritePlacesLocalDataSource,
                PlacesRemoteDataSource,
                PlaceTransformer
            >
        >
    >
    
//    @EnvironmentObject var homePresenter: ListPresenter<String, PlaceDomainModel, Interactor<String, [PlaceDomainModel], PlacesRepository<PlacesLocalDataSource, PlacesRemoteDataSource, PlaceTransformer>>>
    
//    @EnvironmentObject var homePresenter: SearchPresenter<PlaceDomainModel, Interactor<String, [PlaceDomainModel], PlacesRepository<PlacesLocalDataSource, PlacesRemoteDataSource, PlaceTransformer>>>
    
//    @EnvironmentObject var favoritePresenter: SearchPresenter<PlaceDomainModel, Interactor<String, [PlaceDomainModel], FavoritePlacesRepository<FavoritePlacesLocalDataSource, PlacesRemoteDataSource, PlaceTransformer>>>
    
//    @EnvironmentObject var homePresenter: HomePresenter
//    @EnvironmentObject var favoritePresenter: FavoritePresenter
    
    enum TabViews: Int {
        case destinations
        case favorites
        case about
        
        var image: String {
            switch self {
            case .destinations:
                return "house"
            case .favorites:
                return "heart"
            case .about:
                return "person"
            }
        }
        var title: String {
            switch self {
            case .destinations:
                return "Destinations"
            case .favorites:
                return "Favorites"
            case .about:
                return "About"
            }
        }
    }
    
    @State private var selectedTab = TabViews.destinations

    var body: some View {
        TabView {
            HomeView(presenter: homePresenter)
                .tabItem {
                    Image(systemName: TabViews.destinations.image)
                    Text(TabViews.destinations.title)
                }
            
            FavoriteView(presenter: favoritePresenter)
                .tabItem {
                    Image(systemName: TabViews.favorites.image)
                    Text(TabViews.favorites.title)
                }
        
            AboutView()
                .tabItem{
                    Image(systemName: TabViews.about.image)
                    Text(TabViews.about.title)
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
