//
//  ContentView.swift
//  Curv Test
//
//  Created by Cornelius Smith on 2020-07-09.
//  Copyright © 2020 Cornelius Smith. All rights reserved.
//

import SwiftUI


struct ContentView: View {
    var giphyObject = GiphyApi()
    var body: some View {
        trendingView(giphyObject: self.giphyObject)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
