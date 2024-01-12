//
//  CellConfigurable.swift
//  TravelTalk
//
//  Created by 원태영 on 1/12/24.
//

import UIKit

protocol CellConfigurable: UITableViewCell {
  func configureCell()
}

protocol CellDataSettable: CellConfigurable {
  associatedtype Entity: Model
  
  func setData(data: Entity, tag: Int)
}

