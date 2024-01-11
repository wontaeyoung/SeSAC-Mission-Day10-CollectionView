//
//  TravelTableViewCell.swift
//  SeSAC-Mission-Day10-CollectionView
//
//  Created by 원태영 on 1/11/24.
//

import UIKit

final class TravelTableViewCell: UITableViewCell {
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var descLabel: UILabel!
  @IBOutlet weak var starStackView: UIStackView!
  @IBOutlet var starImageViews: [UIImageView]!
  @IBOutlet weak var saveLabel: UILabel!
  @IBOutlet weak var travelImageView: UIImageView!
  @IBOutlet weak var likeButton: UIButton!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
}
