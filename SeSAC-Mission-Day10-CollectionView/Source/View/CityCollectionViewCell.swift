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
  
  override func layoutSubviews() {
    let radius = imageView.bounds.width / 2
    imageView.layer.cornerRadius = radius
  }
  
  func configureCell(city: City) {
    let placeholder = UIImage(systemName: Constant.Symbol.photo)
    imageView.kf.setImage(with: city.url, placeholder: placeholder)
    nameLabel.text = city.name
    explainLabel.text = city.explain
  }
  
  private func defaultConfigure() {
    
    imageView.clipsToBounds = true
    imageView.contentMode = .scaleAspectFill
    
    nameLabel.font = .boldSystemFont(ofSize: 16)
    nameLabel.numberOfLines = 1
    nameLabel.textAlignment = .center
    
    explainLabel.font = .systemFont(ofSize: 14)
    explainLabel.textColor = .gray
    explainLabel.numberOfLines = 0
    explainLabel.textAlignment = .center
  }
}
