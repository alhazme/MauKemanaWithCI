//
//  HomeDetailView.swift
//  MauKemana
//
//  Created by Moch Fariz Al Hazmi on 11/11/20.
//

import SwiftUI
import SDWebImageSwiftUI
import MapKit
import Core
import Place

struct HomeDetailView: View {
    
    @ObservedObject var detailPresenter: PlacePresenter<
        Interactor<
            String,
            PlaceDomainModel,
            PlaceRepository<
                PlacesLocalDataSource,
                PlacesRemoteDataSource,
                PlaceTransformer
            >
        >,
        Interactor<
            String,
            PlaceDomainModel,
            UpdateFavoritePlaceRepository<
                FavoritePlacesLocalDataSource,
                PlacesRemoteDataSource,
                PlaceTransformer
            >
        >,
        Interactor<
            String,
            PlaceDomainModel,
            UpdateUnfavoritePlaceRepository<
                FavoritePlacesLocalDataSource,
                PlacesRemoteDataSource,
                PlaceTransformer
            >
        >
    >
    
//    @ObservedObject var presenter: Presenter<String, PlaceDomainModel, Interactor<String, PlaceDomainModel, PlaceRepository<PlacesLocalDataSource, PlacesRemoteDataSource, PlaceTransformer>>>
//
//    @ObservedObject var updateFavoritePresenter: UpdatePresenter<String, PlaceDomainModel, Interactor<String, PlaceDomainModel, UpdateFavoritePlaceRepository<FavoritePlacesLocalDataSource, PlacesRemoteDataSource, PlaceTransformer>>>
//
//    @ObservedObject var updateUnfavoritePresenter: UpdatePresenter<String, PlaceDomainModel, Interactor<String, PlaceDomainModel, UpdateUnfavoritePlaceRepository<FavoritePlacesLocalDataSource, PlacesRemoteDataSource, PlaceTransformer>>>
    
    var place: PlaceDomainModel
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    photoView
                    descriptionView
                }
            }
            bottomButtons
        }
        .onAppear {
            if self.detailPresenter.item == nil {
                let placeId = "\(place.id)"
                self.detailPresenter.getDetail(request: placeId)
            }
        }
        .navigationBarTitle(
            "Detail",
            displayMode: .automatic
        )
    }
    
    func showDirection(name: String, latitude: Double, longitude: Double) {
        let coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary: nil))
        mapItem.name = "Target location"
        mapItem.openInMaps(
            launchOptions: [
                MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving
            ]
        )
    }
    
    func shareContent(name: String, photo: String, latitude: Double, longitude: Double) {
        let content = "Hai gaes, yuk kita ke \(name). Seperti ini tampilannya \n \(photo). Lokasinya ada di sini nih https://maps.google.com/?ll=\(latitude),\(longitude)"
        let av = UIActivityViewController(activityItems: [content], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
    }
}

extension HomeDetailView {
    var photoView: some View {
        ZStack(
            alignment: Alignment(horizontal: .trailing, vertical: .top)
        ) {
            WebImage(url: URL(string: self.detailPresenter.item?.image ?? ""))
                .resizable()
                .indicator(.activity)
                .transition(.fade(duration: 0.5))
                .scaledToFill()
                .frame(
                    width: UIScreen.main.bounds.size.width,
                    height: UIScreen.main.bounds.size.width,
                    alignment: .center
                )
                .clipped()
            Button(action: {
                guard let place = self.detailPresenter.item else { return }
                let placeId: String = "\(place.id)"
                if  place.favorite {
                    print("isFavorite true then setUnfavoritePlace")
                    self.detailPresenter.setToUnfavorite(request: placeId)
//                    self.updateFavoritePresenter.item = nil
//                    self.updateUnfavoritePresenter.update(request: placeId)
//                    self.updatePresenter.update(request: placeId)
//                    self.presenter.setUnfavoritePlace()
                } else {
                    print("isFavorite false then setFavoritePlace")
                    self.detailPresenter.setToFavorite(request: placeId)
//                    self.updateUnfavoritePresenter.item = nil
//                    self.updateFavoritePresenter.update(request: placeId)
//                    self.updatePresenter.update(request: placeId)
//                    self.presenter.setFavoritePlace()
                }
            },
            label: {
                VStack {
                    Image(systemName: self.detailPresenter.item?.favorite ?? false ? "heart.fill" : "heart")
                        .font(.system(size: 24))
                        .foregroundColor(self.detailPresenter.item?.favorite ?? false ? Color.red : Color.black)
                        .aspectRatio(contentMode: .fill)
                }
                .padding()
                .background(Color.white)
                .mask(Circle())
            })
            .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
        }
        .frame(
            width: UIScreen.main.bounds.size.width,
            height: UIScreen.main.bounds.size.width,
            alignment: Alignment/*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/
        )
    }
    
    var descriptionView: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .top) {
                Text(self.detailPresenter.item?.address ?? "")
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(Color.secondary)
                Spacer()
                Image(systemName: "hand.thumbsup.fill")
                    .foregroundColor(Color.secondary)
                    .font(.system(size: 14))
                Text("\(self.detailPresenter.item?.like ?? 0)")
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(Color.secondary)
            }
            
            Text(self.detailPresenter.item?.name ?? "")
                .font(.largeTitle)
                .foregroundColor(Color.primary)
                .bold()
                .lineLimit(2)
            
            Text(self.detailPresenter.item?.description ?? "")
                .font(.body)
                .foregroundColor(Color.secondary)
        }
        .padding(16)
    }
    
    var bottomButtons: some View {
        HStack(alignment: .center, spacing: 8) {
            Button(
                action: {
                    self.showDirection(
                        name: self.detailPresenter.item?.name ?? "",
                        latitude: self.detailPresenter.item?.latitude ?? 0.0,
                        longitude: self.detailPresenter.item?.longitude ?? 0.0
                    )
                },
                label: {
                    Text("Direction")
                        .font(.system(size: 14))
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .padding(.vertical, 12)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            )
            
            Button(
                action: {
                    self.shareContent(
                        name: self.detailPresenter.item?.name ?? "",
                        photo: self.detailPresenter.item?.image ?? "",
                        latitude: self.detailPresenter.item?.latitude ?? 0.0,
                        longitude: self.detailPresenter.item?.longitude ?? 0.0
                    )
                },
                label: {
                    Text("Share")
                        .font(.system(size: 14))
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .padding(.vertical, 12)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            )
        }.padding(8)
    }
}

struct HomeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//        let place: PlaceModel = PlaceModel(
//            id: 12345,
//            name: "Gunung Bromo",
//            description: "Gunung Bromo ada gunung yang indah",
//            address: "Podokoyo, Tosari, Pasuruan",
//            longitude: 112.9355026,
//            latitude: -7.9424931,
//            like: 100,
//            image: "https://images.unsplash.com/photo-1505993597083-3bd19fb75e57?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1354&q=80",
//            favorite: false
//        )
//        let homeDetailUseCase = Injection.init().provideDetail(place: place)
//        let presenter = HomeDetailPresenter(homeDetailUseCase: homeDetailUseCase)
//        HomeDetailView(presenter: presenter)
    }
}
