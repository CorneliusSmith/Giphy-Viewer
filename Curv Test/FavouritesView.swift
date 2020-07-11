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
    var body: some View {
        NavigationView{
            
            List{
                ForEach(self.favouritesArray, id: \.self){favourite in
                    NavigationLink(destination: detailView(giphyObject: self.giphyObject, gifTitle: favourite, gifURL: "file://\(NSHomeDirectory())/Documents/\(favourite)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)){
                            Text(favourite)
                    }
                }
            }
            .onAppear(){
                self.favouritesArray = []
                let favourites = FileManager().enumerator(atPath: "\(NSHomeDirectory())/Documents")
                for favourite in favourites!{
                    print(favourite as! String)
                    self.favouritesArray.append(favourite as! String)
                }
            }
            .navigationBarTitle("Favourites")
        }
    }
}

//struct FavouritesView_Previews: PreviewProvider {
//    static var previews: some View {
//        FavouritesView()
//    }
//}
