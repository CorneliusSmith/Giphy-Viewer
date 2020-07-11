//
//  CollecionViewCoordinator.swift
//  Curv Test
//
//  Created by Cornelius Smith on 2020-07-11.
//  Copyright © 2020 Cornelius Smith. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

/// The coordinator for the collection view
/// - Parameters:
///   - items: An array of datatypes that specifies what each cell is comprised of
///   - favouritesArray: An array filled with all favourited gifs, to populate the collection view

public class CollectionViewCoordinator<CellType: UICollectionViewCell & Configurable>: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @Binding private var items: [CellType.DataType]
    @Binding public var favouritesArray: [String]
    
    
    public init(_ items: Binding<[CellType.DataType]>, _ favouritesArray: Binding<[String]>) {
        self._favouritesArray = favouritesArray
        self._items = items
    }
    
    /// Tells the CollectionView how many cells are needed to be displayed on screen
    /// - Parameters:
    ///   - items: An array of datatypes that specifies what each cell is comprised of
    ///   - favouritesArray: An array filled with all favourited gifs, to populate the collection view

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    /// Passes the data to the CollectionViewCell to generate the desired view in the cell

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellType.stringIdentifier, for: indexPath) as? CellType ?? CellType()
        cell.configure(using: items[indexPath.row])
        return cell
    }
    
    /// Sets the CollectionView to display in two columns on device
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let dimension = (collectionView.frame.width - 20) / 2
        return .init(width: dimension, height: dimension)
    }
    
    /// On long press a context menu is created on the selected cell
    
    public func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil, actionProvider: { suggestedActions in
            return self.makeContextMenu(indexPath: indexPath, collectionView)
        })
    }

    /// Adds padding to all sides of the CollectionView
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    
    /// Makes the context menu to display a fun message for the bonus portion of this task when it is requested by the CollectionView
    /// - Parameters:
    ///   - indexPath: the path to the selected cell so the context menu can be overlaid over it
    ///   - collectionView: The CollectionView to call the menu on top of
    /// # Note auto layout bug cause by calling the context menu in this version of Swift  https://github.com/apptekstudios/ASCollectionView/issues/77
    func makeContextMenu(indexPath: IndexPath, _ collectionView: UICollectionView) -> UIMenu {
    
        let Message = UIAction(title: "Hi from the context menu", image: UIImage(systemName: "star.fill")) { action in
            print("Howdy!")
        }

        // Create a menu with both the edit menu and the share action
        return UIMenu(title: "Context Menu", children: [Message])
    }
}
