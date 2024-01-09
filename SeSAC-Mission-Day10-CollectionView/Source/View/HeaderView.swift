//
//  HeaderView.swift
//  SeSAC-Mission-Day10-CollectionView
//
//  Created by 원태영 on 1/9/24.
//

import UIKit

final class HeaderView: UIView {
  
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var devider: UIView!
  
  func configureUI() {
    imageView.image = UIImage(systemName: Constant.Symbol.ellipsis)?.configured(color: .gray)
    
    titleLabel.text = Constant.Label.headerTitle
    titleLabel.font = .boldSystemFont(ofSize: 16)
    titleLabel.textAlignment = .center
    
    devider.backgroundColor = .systemGray3
  }
}
