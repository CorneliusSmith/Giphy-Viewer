//
//  trendingView.swift
//  Curv Test
//
//  Created by Cornelius Smith on 2020-07-09.
//  Copyright © 2020 Cornelius Smith. All rights reserved.
//

import SwiftUI


struct TrendingView: View {
    @ObservedObject var giphyObject: GiphyApi
    @Binding var searchString: String
    
    var body: some View {
        NavigationView{
            VStack{
                SearchView(giphyObject: self.giphyObject, searchString: self.$searchString)
                if self.giphyObject.isFinished{
                    List{
                            // populates list with latest trending gifs
                            if  !self.giphyObject.doneSearching{
                                ForEach(self.giphyObject.trendingResponse.data, id: \.self){trendingGif in
                                    NavigationLink(destination: DetailView(giphyObject: self.giphyObject, gifTitle: trendingGif.title!, gifURL: "https://media1.giphy.com/media/\(trendingGif.id!)/200w.mp4")){
                                        Text(trendingGif.title!)
                                    }.onAppear(){
                                        let lastItem = self.giphyObject.trendingResponse.data.last?.title
                                        if trendingGif.title == lastItem{
                                            self.giphyObject.getMoreTrendingGifs()
                                        }
                                    }
                                }
                            }
                            // populates list with gifs from search results
                            else{
                            ForEach(self.giphyObject.trendingResponse.data, id: \.self){trendingGif in
                                NavigationLink(destination: DetailView(giphyObject: self.giphyObject, gifTitle: trendingGif.title!, gifURL: "https://media1.giphy.com/media/\(trendingGif.id!)/200w.mp4")){
                                    Text(trendingGif.title!)
                                }
                                .onAppear(){
                                    let lastItem = self.giphyObject.trendingResponse.data.last?.title
                                    if trendingGif.title == lastItem{
                                        self.giphyObject.getMoreSearchedGifs(query: self.searchString)
                                    }
                                }
                            }
                        }
                    }
                }
                // creates indicatior to tell user when searches are loading
                else{
                    ZStack{
                        RoundedRectangle(cornerRadius: 16)
                            .foregroundColor(Color.gray)
                            .frame(width: 100, height: 100, alignment: .center)
                        Text("Loading...")
                            .foregroundColor(.white)
                    }
                }
                
                
                Spacer()
            }
            .onAppear{
                if self.searchString == ""{
                    self.giphyObject.getTrendingGifs()
                }
            }
            .navigationBarTitle("Trending")
        }
    }
}
