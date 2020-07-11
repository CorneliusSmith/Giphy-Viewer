//
//  FavouritesView.swift
//  Curv Test
//
//  Created by Cornelius Smith on 2020-07-10.
//  Copyright © 2020 Cornelius Smith. All rights reserved.
//

import SwiftUI
import UIKit

struct FavouritesView: View {
    @ObservedObject var giphyObject: GiphyApi
    @State var data: [Int]
    @State var changeView = false
    
    
    @State var favouritesArray: [String] = []
    @State var populatingFavourites: Bool = true
    var body: some View {
        NavigationView{
            VStack{
                if (!self.changeView){
                    CollectionView<CollectionViewCell>(items: self.$favouritesArray, self.$favouritesArray)
                }
                else{
                    List{
                        if (!self.populatingFavourites){
                       /// Reversed favouritesArray so favourites appear in mostly the order they were favourited.
                       /// Mostly because the getFavourites function doesnt filter the files by creation date or anything so they are populated randomly,
                       /// with most of the order preserved.
                            ForEach(self.favouritesArray.reversed(), id: \.self){favourite in
                                NavigationLink(destination: DetailView(giphyObject: self.giphyObject, gifTitle: favourite, gifURL: "file://\(NSHomeDirectory())/Documents/\(favourite)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)){
                                    Text(favourite)
                                }
                           }
                       }
                   }
                }
            }
            .onAppear(){
                self.getFavourites()
            }
            .navigationBarTitle("Favourites")
            .navigationBarItems(trailing: Toggle(isOn: self.$changeView){Text("")})
        }
    }
    
    /// A function to populate the favourites array with the saved gifs in a users Documents folder
    func getFavourites(){
        self.favouritesArray = []
        let favourites = FileManager().enumerator(atPath: "\(NSHomeDirectory())/Documents")
        for favourite in favourites!.reversed(){
            self.favouritesArray.append(favourite as! String)
        }
        self.populatingFavourites = false
    }
}

/// A ViewRepresentble where the CollectionView is setup to be used with swiftUI

public struct CollectionView<CellType: UICollectionViewCell & Configurable>: UIViewRepresentable {
    @Binding public var items: [CellType.DataType]
    @Binding var favouritesArray: [String]
    
    private let layout: UICollectionViewFlowLayout
  
    public init(items: Binding<[CellType.DataType]>, _ favouritesArray: Binding<[String]>) {
        self._items = items
        self.layout = UICollectionViewFlowLayout()
        self._favouritesArray = favouritesArray
    }
    
    
    /**
     Reloads the collection view when needed
     
     - Parameters:
       - uiView: The CollectionView to be reloaded
       - context: The coordinator to carry out the update
     
     */
    public func updateUIView(_ uiView: GenericCollectionView<CellType>, context: Context) {
        uiView.reloadData()
    }
      
    /// Creates the initial UIView
    public func makeUIView(context: Context) -> GenericCollectionView<CellType> {
        let view = GenericCollectionView<CellType>.init(frame: .zero, collectionViewLayout: layout)
        view.dataSource = context.coordinator
        view.delegate = context.coordinator
        return view
    }
    
    /// Creates the coordinator for the CollectionView
    public func makeCoordinator() -> CollectionViewCoordinator<CellType> {
        CollectionViewCoordinator($items, self.$favouritesArray)
    }
}
