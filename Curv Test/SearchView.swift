//
//  SearchView.swift
//  Curv Test
//
//  Created by Cornelius Smith on 2020-07-10.
//  Copyright © 2020 Cornelius Smith. All rights reserved.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var giphyObject : GiphyApi
    @Binding var searchString: String 

    var body: some View {
        VStack{
            HStack{
                TextField("Search Gif",text: self.$searchString)
                    .padding()
                    .padding(.trailing, 10)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                Spacer()
                Button(action: {
                    
                    //gets searched gifs or trending gifs based on whats in the search bar
                    if self.searchString != ""{
                        self.giphyObject.lastSearchedGif = 25 //resets the search offset for new searches
                        self.giphyObject.getSearchedGifs(query: self.searchString)
                    }
                    else{
                        // repopulates trending gifs and resets trending offset afteer search
                        self.giphyObject.doneSearching = false
                        self.giphyObject.getTrendingGifs()
                        self.giphyObject.lastTrendingGif = 25
                    }
                    
                    //code to hide keyboard on tap of the search button
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                })
                {
                    Image(systemName: "magnifyingglass.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                }
            }.padding()
        }
    }
}

//struct SearchView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchView()
//    }
//}
