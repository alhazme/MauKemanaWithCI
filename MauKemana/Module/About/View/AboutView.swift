//
//  AboutView.swift
//  MauKemana
//
//  Created by Moch Fariz Al Hazmi on 15/11/20.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Image("fariz")
                        .resizable()
                        .clipShape(Circle())
                        .scaledToFit()
                        .frame(width: 100, height: 100, alignment: .center)
                        .padding(EdgeInsets(top: 32, leading: 0, bottom: 0, trailing: 0))
                    Text("Moch. Fariz Al Hazmi")
                        .font(.title)
                        .bold()
                        .padding(EdgeInsets(top: 32, leading: 0, bottom: 0, trailing: 0))
                    Text("mas.aiz.azmi@gmail.com")
                        .font(.system(size: 17))
                        .padding(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0))
                    Text("https://alhaz.me")
                        .font(.system(size: 17))
                        .padding(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0))
                    Spacer()
                    Button(
                        action: {
                            self.shareProfile()
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
                    .padding(16)
                }
            }
            .navigationBarTitle(
                "About",
                displayMode: .automatic
            )
        }
    }
    
    func shareProfile() {
        let content = "Hai, Kamu lagi butuh develop iOS App dan lagi cari iOS Developer, Aku rekomendasiin ke mas Fariz aja. App yang pernah Dia bikin bisa Kamu cek sendiri di https://alhaz.me\nKalau tertarik langsung kirim email aja ke mas.aiz.azmi@gmail.com"
        let av = UIActivityViewController(activityItems: [content], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
