//
//  detailView.swift
//  Curv Test
//
//  Created by Cornelius Smith on 2020-07-09.
//  Copyright © 2020 Cornelius Smith. All rights reserved.
//

import SwiftUI
import UIKit

struct DetailView: View {
    @ObservedObject var giphyObject: GiphyApi
    var gifTitle: String
    var gifURL: String
    var sizeRect = UIScreen.main.bounds
    
    var body: some View {
        VStack{
            GifView(gifURL: URL(string: self.gifURL)!)
                    .frame(width: sizeRect.width, height: 400, alignment: .center)
            HStack{
                Text("Favourite/Unfavourite:")
                    .font(.title)
                Button(action: {
                    //print(self.gifURL)
                    do {
                        try URL(string: self.gifURL)!.download(to: .documentDirectory, fileName: "\(self.gifTitle)") { url, error in
                                //self.giphyObject.populateFavourites()
                        }
                    } catch {
                        print(error)
                    }
                    //self.giphyObject.downloadGif()
                }){
                    Image(systemName: "star.fill")
                    .resizable()
                    .frame(width: 25, height: 25)
                }
            }.onAppear(){
                print(self.gifURL)
            }
                
            
            Spacer()
        }.navigationBarTitle(Text(self.gifTitle), displayMode: .inline)
    }
}

//struct detailView_Previews: PreviewProvider {
//    static var previews: some View {
//        detailView()
//    }
//}
