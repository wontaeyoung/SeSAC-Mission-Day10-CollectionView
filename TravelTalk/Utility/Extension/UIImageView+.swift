//
//  UIImageView+.swift
//  TravelTalk
//
//  Created by 원태영 on 1/13/24.
//

import UIKit

extension UIImageView {
  func setCornerRadius(radius: CGFloat) {
    self.clipsToBounds = true
    self.layer.cornerRadius = radius
  }
  
  func circleShape() {
    let radius: CGFloat = self.bounds.width / 2
    self.clipsToBounds = true
    self.layer.cornerRadius = radius
    self.layer.borderWidth = 1
    self.layer.borderColor = UIColor.lightGray.cgColor
  }
}
