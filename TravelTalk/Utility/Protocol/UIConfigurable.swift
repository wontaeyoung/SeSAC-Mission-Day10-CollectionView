//
//  UIConfigurable.swift
//  TravelTalk
//
//  Created by 원태영 on 1/12/24.
//

import UIKit

protocol UIConfigurable: UIViewController {
  func configureUI()
}

protocol Registerable: UIConfigurable {
  func register()
}

protocol CollectionUIConfigurable: Registerable {
  func configureCollectionView()
}

protocol TableUIConfigurable: Registerable {
  func configureTableView()
}
