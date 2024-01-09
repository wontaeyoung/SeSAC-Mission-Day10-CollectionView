//
//  CityCollectionViewCell.swift
//  SeSAC-Mission-Day10-CollectionView
//
//  Created by 원태영 on 1/9/24.
//

import UIKit
import Kingfisher

final class CityCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var explainLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    defaultConfigure()
  }
  
  func configureCell(city: City) {
    let placeholder = UIImage(systemName: Constant.Symbol.photo)
    imageView.kf.setImage(with: city.url, placeholder: placeholder)
    nameLabel.text = city.name
    explainLabel.text = city.explain
  }
  
  private func defaultConfigure() {
    imageView.layer.cornerRadius = imageView.frame.height / 2
    imageView.clipsToBounds = true
    
    nameLabel.font = .boldSystemFont(ofSize: 16)
    nameLabel.numberOfLines = 1
    nameLabel.textAlignment = .center
    
    explainLabel.font = .systemFont(ofSize: 14)
    explainLabel.numberOfLines = 0
    explainLabel.textAlignment = .center
  }
}
