//
//  ADTableViewCell.swift
//  SeSAC-Mission-Day10-CollectionView
//
//  Created by 원태영 on 1/11/24.
//

import UIKit

final class ADTableViewCell: UITableViewCell {
  
  typealias Entity = Travel
  
  @IBOutlet weak var capsuleView: UIView!
  @IBOutlet weak var adContentLabel: UILabel!
  @IBOutlet weak var adMarkLabel: UILabel!
  
  static let identifier: String = "ADTableViewCell"
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    configureCell()
  }
}

extension ADTableViewCell: CellDataSettable {
  
  func configureCell() {
    capsuleView.backgroundColor = UIColor(
      red: .random(in: 0...1),
      green: .random(in: 0...1),
      blue: .random(in: 0...1),
      alpha: 1
    )
    capsuleView.clipsToBounds = true
    capsuleView.layer.cornerRadius = 10
    
    adContentLabel.configure(
      font: .boldSystemFont(ofSize: 16),
      color: .black,
      lineNumber: 0,
      alignment: .center
    )
    
    adMarkLabel.configure(
      text: "AD",
      font: .systemFont(ofSize: 16),
      color: .black,
      lineNumber: 1,
      alignment: .center
    )
    
    adMarkLabel.backgroundColor = .white
    adMarkLabel.clipsToBounds = true
    adMarkLabel.layer.cornerRadius = 5
  }
  
  func setData(data: Travel) {
    adContentLabel.text = data.title
  }
}
