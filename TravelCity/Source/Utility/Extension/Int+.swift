//
//  Int+.swift
//  SeSAC-Mission-Day10-CollectionView
//
//  Created by 원태영 on 1/11/24.
//

import Foundation

extension Int {
  var demicalNumberFormatted: String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    
    return formatter.string(for: self) ?? self.description
  }
}
