//
//  SearchView.swift
//  Curv Test
//
//  Created by Cornelius Smith on 2020-07-10.
//  Copyright © 2020 Cornelius Smith. All rights reserved.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var giphyObject = GiphyApi()
    @Binding var searchString: String 

    var body: some View {
        VStack{
            HStack{
                TextField("Search Gif",text: self.$searchString)
                    .frame(width: 300)
                    .padding()
                    .padding(.trailing, 10)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                Spacer()
                Button(action: {
                    
                    //gets searched gifs or trending gifs based on whats in the search bar
                    if self.searchString != ""{
                        self.giphyObject.getSearchedGifs(query: self.searchString)
                    }
                    else{
                        self.giphyObject.getTrendingGifs()
                    }
                    
                    //code to hide keyboard on tap of the search button
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                })
                {
                    Image(systemName: "magnifyingglass.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    
                }
                Spacer()
            }.padding()
        }
    }
}

//struct SearchView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchView()
//    }
//}
