//
//  ContentView.swift
//  Curv Test
//
//  Created by Cornelius Smith on 2020-07-09.
//  Copyright © 2020 Cornelius Smith. All rights reserved.
//

import SwiftUI


struct ContentView: View {
    @ObservedObject var giphyObject = GiphyApi()
    @State var searchString: String = ""
    @State private var selection = 0
    
    
    var body: some View {
        TabView(selection: $selection){
            trendingView(giphyObject: self.giphyObject, searchString: self.$searchString)
                .tabItem {
                    VStack {
                        Image(systemName: "circle.fill")
                        Text("Trending")
                    }
                }
                .tag(0)
            
                FavouritesView()
                    .tabItem {
                        VStack {
                            Image(systemName: "star.fill")
                            Text("Favourites")
                        }
                    }
                    .tag(1)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
