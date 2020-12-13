//
//  CustomEmptyView.swift
//  MauKemana
//
//  Created by Moch Fariz Al Hazmi on 13/12/20.
//

import SwiftUI

struct CustomEmptyView: View {
    
    var image: String
    var title: String
  
    var body: some View {
        VStack {
            Image(image)
                .resizable()
                .renderingMode(.original)
                .scaledToFit()
                .frame(width: 250)
      
            Text(title)
                .font(.system(.body, design: .rounded))
        }
    }
    
}
