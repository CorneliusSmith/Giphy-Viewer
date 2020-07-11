//
//  CollectionViewCell.swift
//  Curv Test
//
//  Created by Cornelius Smith on 2020-07-11.
//  Copyright © 2020 Cornelius Smith. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

public extension UICollectionViewCell {
  static var stringIdentifier: String { String(describing: Self.self) }
}

public protocol Configurable {
  associatedtype DataType
  func configure(using data: DataType) -> Void
}

/// Creates a class to modify the CollectionViewCell

public class CollectionViewCell<DataType: CustomStringConvertible>: UICollectionViewCell, Configurable {
    /// Sets a custom view to the GifPlayer view  to show in each cell later
    let customView = UIHostingController(rootView: GifView(gifURL: URL(string: "none")!, showPlayerControls: false))
    
    
    /// Overrides the reqular initializer for the CollectionViewCell
    public override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        sharedInit()
    }
    
    /// Initializes the CollectionViewCells to add our customView above as a subview and andchors the subview to the centre of the CollectionView
    private func sharedInit() {
        customView.view.translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.clear
        clipsToBounds = false

        addSubview(customView.view)
        customView.view.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        customView.view.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        customView.view.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        customView.view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    
    /**
     For each favourited gif generate a GifView for it and make that the rootView of the collectionView
     
     - Parameters:
       - data: The data passesd to the cell from the CollectionView with a sting called description containign the name of a favourited gif
     
     */
    
    public func configure(using data: DataType) {
        let favouriteURL = "file://\(NSHomeDirectory())/Documents/\(data.description)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        customView.rootView = GifView(gifURL: URL(string: favouriteURL)!, showPlayerControls: false)
    }
}
