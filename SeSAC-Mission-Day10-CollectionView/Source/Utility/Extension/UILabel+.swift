//
//  UILabel+.swift
//  SeSAC-Mission-Day10-CollectionView
//
//  Created by 원태영 on 1/10/24.
//

import UIKit

extension UILabel {
  func configure(
    text: String? = nil,
    font: UIFont? = nil,
    color: UIColor? = nil,
    lineNumber: Int? = nil,
    alignment: NSTextAlignment? = nil
  ) {
    if let text { self.text = text }
    if let font { self.font = font }
    if let color { self.textColor = color }
    if let lineNumber { self.numberOfLines = lineNumber }
    if let alignment { self.textAlignment = textAlignment }
  }
}
