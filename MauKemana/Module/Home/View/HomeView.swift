//
//  HomeView.swift
//  MauKemana
//
//  Created by Moch Fariz Al Hazmi on 03/11/20.
//

import SwiftUI
import Core
import Place

struct HomeView: View {
    
    @ObservedObject var presenter: PlacesPresenter<
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
    
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    if presenter.isLoading {
                        Spacer()
                        VStack {
                            Text("Loading...")
                            ActivityIndicator()
                        }
                        Spacer()
                    } else if presenter.isError {
                        Spacer()
                        CustomEmptyView(
                            image: "connection",
                            title: "Please Check Your Internet Connection"
                        )
                        Spacer()
                    } else if presenter.list.isEmpty {
                        Spacer()
                        CustomEmptyView(
                            image: "empty",
                            title: "Destination is Empty"
                        )
                        Spacer()
                    } else {
                        SearchBar(text: $searchText)
                            .onChange(of: searchText, perform: { _ in
                                if searchText.count > 0 {
                                    self.presenter.search(keyword: searchText)
                                } else {
                                    self.presenter.load()
                                }
                            })
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
                if presenter.list.isEmpty {
                    self.presenter.load()
                }
            }
            .navigationBarTitle(
                "Destinations",
                displayMode: .automatic
            )
        }
    }
    
    func linkBuilder<Content: View>(
        for place: PlaceDomainModel,
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(
            destination: HomeRouter().makeDetailView(for: place)
        ) { content() }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}
