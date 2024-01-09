//
//  CityCollectionViewCell.swift
//  SeSAC-Mission-Day10-CollectionView
//
//  Created by 원태영 on 1/9/24.
//

import UIKit

final class CityCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var explainLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
  }
}
