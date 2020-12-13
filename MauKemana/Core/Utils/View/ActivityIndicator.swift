//
//  ActivityIndicator.swift
//  MauKemana
//
//  Created by Moch Fariz Al Hazmi on 13/12/20.
//

import SwiftUI

struct ActivityIndicator: UIViewRepresentable {
    
    func makeUIView(
        context: UIViewRepresentableContext<ActivityIndicator>
    ) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: .large)
    }
    
    func updateUIView(
        _ uiView: UIActivityIndicatorView,
        context: UIViewRepresentableContext<ActivityIndicator>
    ) {
        uiView.startAnimating()
    }

}
