//
//  CellConfigurable.swift
//  SeSAC-Mission-Day10-CollectionView
//
//  Created by 원태영 on 1/11/24.
//

import UIKit

protocol CellConfigurable: UITableViewCell {
  func configureCell()
}

protocol CellDataSettable: CellConfigurable {
  associatedtype Entity: Model
  
  func setData(data: Entity, tag: Int)
}
