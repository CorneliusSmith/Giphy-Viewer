//
//  detailView.swift
//  Curv Test
//
//  Created by Cornelius Smith on 2020-07-09.
//  Copyright © 2020 Cornelius Smith. All rights reserved.
//

import SwiftUI

struct detailView: View {
    var gifTitle: String
    var gifURL: String
    
    var body: some View {
        VStack{
            VideoView(videoURL: URL(string: gifURL)!, previewLength: 2)
            .cornerRadius(15)
            .frame(width: nil, height: 200, alignment: .center)
            .shadow(color: Color.black.opacity(0.7), radius: 30, x: 0, y: 2)
            .padding(.horizontal, 20)
            .padding(.top, 20)
        }.navigationBarTitle(Text(self.gifTitle), displayMode: .inline)
    }
}

//struct detailView_Previews: PreviewProvider {
//    static var previews: some View {
//        detailView()
//    }
//}
