//
//  UIConfigurable.swift
//  SeSAC-Mission-Day10-CollectionView
//
//  Created by 원태영 on 1/10/24.
//

import UIKit

protocol UIConfigurable: UIViewController {
  func configureUI()
}

protocol CollectionUIConfigurable: UIConfigurable {
  func register()
  func configureCollectionView()
}

protocol CellConfigurable: UITableViewCell {
  func configureCell()
}
