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
  
  func resized(newWidth: CGFloat) -> UIImage {
    let scale: CGFloat = newWidth / self.size.width
    let newHeight: CGFloat = scale * self.size.height
    
    let size = CGSize(width: newWidth, height: newHeight)
    let render = UIGraphicsImageRenderer(size: size)
    let renderImage = render.image { context in
      self.draw(in: CGRect(origin: .zero, size: size))
    }
    
    return renderImage
  }
}
