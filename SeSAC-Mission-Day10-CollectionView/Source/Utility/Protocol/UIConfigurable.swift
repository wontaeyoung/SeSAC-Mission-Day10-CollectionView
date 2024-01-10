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
  var reuseIdentifier: String { get }
  
  func register(identifier: String)
}
