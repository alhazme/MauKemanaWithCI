//
//  PlaceRow.swift
//  MauKemana
//
//  Created by Moch Fariz Al Hazmi on 10/11/20.
//

import SwiftUI
import SDWebImageSwiftUI
import Core
import Place

struct PlaceRow: View {
    
    var place: PlaceDomainModel
    var body: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 0) {
                photoView
                titleView
            }
            .cornerRadius(10)
            .padding(.horizontal, 8)
        }
    }
}

extension PlaceRow {
    
    var photoView: some View {
        WebImage(url: URL(string: place.image))
            .resizable()
            .indicator(.activity)
            .transition(.fade(duration: 0.5))
            .aspectRatio(contentMode: .fill)
            .frame(maxWidth: UIScreen.main.bounds.size.width - 16)
            .frame(height: 300)
            .clipped()
//          .scaledToFit()
    }
    
    var titleView: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .top) {
                Text(place.address)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(Color.secondary)
                Spacer()
                Image(systemName: "hand.thumbsup.fill")
                    .foregroundColor(Color.secondary)
                    .font(.system(size: 14))
                Text("\(place.like)")
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(Color.secondary)
            }
            Text(place.name)
                .font(.largeTitle)
                .foregroundColor(Color.primary)
                .bold()
                .lineLimit(2)
        }
        .padding(16)
        .background(Color.gray.opacity(0.5))
    }
}

struct PlaceRow_Previews: PreviewProvider {
    static var previews: some View {
        let place: PlaceDomainModel = PlaceDomainModel(
            id: 12345,
            name: "Gunung Bromo",
            description: "Gunung Bromo ada gunung yang indah",
            address: "Podokoyo, Tosari, Pasuruan",
            longitude: 112.9355026,
            latitude: -7.9424931,
            like: 100,
            image: "https://images.unsplash.com/photo-1505993597083-3bd19fb75e57?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1354&q=80",
            favorite: false
        )
        PlaceRow(place: place)
    }
}
