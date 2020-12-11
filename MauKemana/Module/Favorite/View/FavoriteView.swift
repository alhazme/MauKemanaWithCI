//
//  FavoriteView.swift
//  MauKemana
//
//  Created by Moch Fariz Al Hazmi on 13/11/20.
//

import SwiftUI
import Core
import Place

struct FavoriteView: View {
    
    @ObservedObject var presenter: PlacesPresenter<
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
    
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    SearchBar(text: $searchText)
                        .onChange(of: searchText, perform: { _ in
                            if searchText.count > 0 {
                                self.presenter.search(keyword: searchText)
                            } else {
                                self.presenter.load()
                            }
                        })
                        if presenter.isLoading {
                            Spacer()
                        } else if presenter.isError {
                            Spacer()
                        } else if presenter.list.isEmpty {
                            Spacer()
                        } else {
                            ScrollView(.vertical, showsIndicators: false) {
                                ForEach(
                                    self.presenter.list,
                                    id: \.id
                                ) { place in
                                    ZStack {
                                        linkBuilder(for: place) {
                                            PlaceRow(place: place)
                                        }.buttonStyle(PlainButtonStyle())
                                    }
                                }
                            }
                        }
                }
                
            }
            .onAppear {
                self.presenter.load()
            }
            .navigationBarTitle(
                "Favorites",
                displayMode: .automatic
            )
        }
    }
    
    func linkBuilder<Content: View>(
        for place: PlaceDomainModel,
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(
            destination: FavoriteRouter().makeDetailView(for: place)
        ) { content() }
    }
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}