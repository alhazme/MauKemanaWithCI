//
//  SceneDelegate.swift
//  MauKemana
//
//  Created by Moch Fariz Al Hazmi on 31/10/20.
//

import UIKit
import SwiftUI
import RealmSwift
import Core
import Place

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    // https://sarunw.com/posts/how-to-create-new-xcode-project-without-storyboard/
    // https://stackoverflow.com/a/50719379
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        // Home
        let listPlacesUseCase: Interactor<
            String,
            [PlaceDomainModel],
            PlacesRepository<
                PlacesLocalDataSource,
                PlacesRemoteDataSource,
                PlaceTransformer
            >
        > = Injection.init().providePlaces()
        
        let searchPlacesUseCase: Interactor<
            String,
            [PlaceDomainModel],
            PlacesRepository<
                PlacesLocalDataSource,
                PlacesRemoteDataSource,
                PlaceTransformer
            >
        > = Injection.init().providePlaces()
        
        let homePresenter: PlacesPresenter = PlacesPresenter(
            listUseCase: listPlacesUseCase,
            searchUseCase: searchPlacesUseCase
        )
        
        // Favorite
        let listFavoritePlacesUseCase: Interactor<
            String,
            [PlaceDomainModel],
            FavoritePlacesRepository<
                FavoritePlacesLocalDataSource,
                PlacesRemoteDataSource,
                PlaceTransformer
            >
        > = Injection.init().provideFavoritePlaces()
        
        let searchFavoritePlacesUseCase: Interactor<
            String,
            [PlaceDomainModel],
            FavoritePlacesRepository<
                FavoritePlacesLocalDataSource,
                PlacesRemoteDataSource,
                PlaceTransformer
            >
        > = Injection.init().provideFavoritePlaces()
        
        let favoritePresenter: PlacesPresenter = PlacesPresenter(
            listUseCase: listFavoritePlacesUseCase,
            searchUseCase: searchFavoritePlacesUseCase
        )
        
        let contentView = ContentView()
            .environmentObject(homePresenter)
            .environmentObject(favoritePresenter)
        
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
        
        /*
        let searchPlaceUseCase: Interactor<String, [PlaceDomainModel], PlacesRepository<PlacesLocalDataSource, PlacesRemoteDataSource, PlaceTransformer>> = Injection.init().providePlaces()
        
        let searchFavoritePlaceUseCase: Interactor<String, [PlaceDomainModel], FavoritePlacesRepository<FavoritePlacesLocalDataSource, PlacesRemoteDataSource, PlaceTransformer>> = Injection.init().provideFavoritePlaces()
        
        let homePresenter = SearchPresenter(
            useCase: searchPlaceUseCase
        )
        
        let favoritePresenter = SearchPresenter(
            useCase: searchFavoritePlaceUseCase
        )
        
        let contentView = ContentView()
            .environmentObject(homePresenter)
            .environmentObject(favoritePresenter)
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
        */
        
        /*
        if scene as? UIWindowScene != nil {
            let homeUseCase = Injection.init().provideHome()
            let homePresenter = HomePresenter(homeUseCase: homeUseCase)
            let favoriteUseCase = Injection.init().provideFavorite()
            let favoritePresenter = FavoritePresenter(favoriteUseCase: favoriteUseCase)
            let contentView = ContentView()
                .environmentObject(homePresenter)
                .environmentObject(favoritePresenter)
            if let windowScene = scene as? UIWindowScene {
                let window = UIWindow(windowScene: windowScene)
                window.rootViewController = UIHostingController(rootView: contentView)
                self.window = window
                window.makeKeyAndVisible()
            }
        }
        */
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
}
