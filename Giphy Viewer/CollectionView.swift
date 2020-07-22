//
//  CollectionView.swift
//  Curv Test
//
//  Created by Cornelius Smith on 2020-07-11.
//  Copyright © 2020 Cornelius Smith. All rights reserved.
//

import Foundation
import UIKit

/// Calls a configurable CollectionView using this tutorial as a base: https://medium.com/swlh/porting-uicollectionview-to-swiftui-afd8fc036323

public class GenericCollectionView<CellType: UICollectionViewCell & Configurable>: UICollectionView {
  public override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
    super.init(frame: frame, collectionViewLayout: layout)
    sharedInit()
  }
  
  public required init?(coder: NSCoder) {
    super.init(coder: coder)
    sharedInit()
  }
  
  private func sharedInit() {
    backgroundColor = .clear
    register(CellType.self, forCellWithReuseIdentifier: CellType.stringIdentifier)
  }
}
