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
  
  static let identifier: String = Constant.Identifier.cityCollectionViewCell
  
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
    nameLabel.text = city.labelName
    explainLabel.text = city.explain
  }
  
  func setAttributedLabel(text: String, city: City) {
    guard city.searchKeywordContains(text: text.lowercased()) else {
      return
    }
    
    let attributedNameString = NSMutableAttributedString(string: nameLabel.text!)
    let attributedExplainString = NSMutableAttributedString(string: explainLabel.text!)
    
    attributedNameString.addAttribute(.foregroundColor, value: UIColor.systemIndigo, range: (nameLabel.text! as NSString).range(of: text))
    attributedExplainString.addAttribute(.foregroundColor, value: UIColor.systemIndigo, range: (explainLabel.text! as NSString).range(of: text))
    
    nameLabel.attributedText = attributedNameString
    explainLabel.attributedText = attributedExplainString
  }
  
  private func defaultConfigure() {
    
    imageView.clipsToBounds = true
    imageView.contentMode = .scaleAspectFill
    
    nameLabel.configure(
      font: .boldSystemFont(ofSize: 16),
      lineNumber: 1,
      alignment: .center
    )
    
    explainLabel.configure(
      font: .systemFont(ofSize: 14),
      color: .gray,
      lineNumber: 0,
      alignment: .center
    )
  }
}
