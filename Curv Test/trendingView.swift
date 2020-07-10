//
//  trendingView.swift
//  Curv Test
//
//  Created by Cornelius Smith on 2020-07-09.
//  Copyright © 2020 Cornelius Smith. All rights reserved.
//

import SwiftUI
struct trendingView: View {
    @ObservedObject var giphyObject: GiphyApi

    var body: some View {
        NavigationView{
            List{
                if self.giphyObject.isFinished{
                    ForEach(self.giphyObject.trendingResponse.data, id: \.self){trendingGif in
                        NavigationLink(destination: detailView(gifTitle: trendingGif.title!, gifURL: "https://media1.giphy.com/media/\(trendingGif.id!)/200w.mp4")){
                            Text(trendingGif.title!)
                        }
                    }
                }
            }.onAppear{
                self.giphyObject.getTrendingGifs()
            }
        }
    }
}

//struct trendingView_Previews: PreviewProvider {
//    static var previews: some View {
//        trendingView()
//    }
//}
