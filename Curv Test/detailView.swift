//
//  detailView.swift
//  Curv Test
//
//  Created by Cornelius Smith on 2020-07-09.
//  Copyright © 2020 Cornelius Smith. All rights reserved.
//

import SwiftUI
import UIKit

struct detailView: View {
    var gifTitle: String
    var gifURL: String
    var sizeRect = UIScreen.main.bounds
    
    var body: some View {
        VStack{
                VideoView(videoURL: URL(string: gifURL)!)
                    .frame(width: sizeRect.width, height: 400, alignment: .center)
            
            Spacer()
        }.navigationBarTitle(Text(self.gifTitle), displayMode: .inline)
    }
}

//struct detailView_Previews: PreviewProvider {
//    static var previews: some View {
//        detailView()
//    }
//}
