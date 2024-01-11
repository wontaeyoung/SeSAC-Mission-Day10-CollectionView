//
//  Constant.swift
//  SeSAC-Mission-Day10-CollectionView
//
//  Created by 원태영 on 1/9/24.
//

import Foundation

enum Constant {
  enum Symbol {
    static let ellipsis: String = "ellipsis"
    static let photo: String = "photo"
    static let heart: String = "heart"
    static let starFill: String = "star.fill"
    static let starLeadinghalfFilled: String = "star.leadinghalf.filled"
  }
  
  enum Label {
    static let headerTitle: String = "인기 도시"
  }
  
  enum CollectionView {
    static let cityCollectionViewCell: String = "CityCollectionViewCell"
    static let spacing: CGFloat = 24
    static let cellCount: Int = 2
    static let cellLabelFreeSpace: CGFloat = 75
  }
}
