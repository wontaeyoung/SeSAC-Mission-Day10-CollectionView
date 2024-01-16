//
//  UIImage+.swift
//  TravelTheater
//
//  Created by 원태영 on 1/16/24.
//

import UIKit

extension UIImage {
  func configured(size: CGFloat?, color: UIColor) -> UIImage {
    var image: UIImage = self
    
    if let size {
      let font: UIFont = .systemFont(ofSize: size)
      let config = SymbolConfiguration(font: font)
      
      image = image.withConfiguration(config)
    }
    
    return image
      .withTintColor(color, renderingMode: .alwaysOriginal)
  }
}
