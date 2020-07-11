//
//  FavouritesView.swift
//  Curv Test
//
//  Created by Cornelius Smith on 2020-07-10.
//  Copyright © 2020 Cornelius Smith. All rights reserved.
//

import SwiftUI

struct FavouritesView: View {
    @ObservedObject var giphyObject: GiphyApi
    
    @State var favouritesArray: [String] = []
    //let path = Bundle.main.resourcePath!

    
    
    var body: some View {
        NavigationView{
            
            List{
                ForEach(self.giphyObject.favouritesArray, id: \.self){favourite in
                    NavigationLink(destination: detailView(giphyObject: self.giphyObject, gifTitle: favourite, gifURL: "file://\(NSHomeDirectory())/Documents/\(favourite)/".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)){
                            Text(favourite)
                    }
                }
            }
            //GifView(gifURL: self.giphyObject.localURL)
        //file:///var/mobile/Containers/Data/Application/76F366B4-1D91-455B-BB77-8983FEB1145E/Documents/200w.mp4
        }
    }
}

//struct FavouritesView_Previews: PreviewProvider {
//    static var previews: some View {
//        FavouritesView()
//    }
//}
