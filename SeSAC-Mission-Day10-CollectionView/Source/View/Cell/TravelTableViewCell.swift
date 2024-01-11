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
    
    configureCell()
  }
}

extension TravelTableViewCell: CellConfigurable {
  func configureCell() {
    titleLabel.configure(
      font: .boldSystemFont(ofSize: 16),
      alignment: .left
    )
    
    descLabel.configure(
      font: .systemFont(ofSize: 12), 
      color: .darkGray,
      lineNumber: 0,
      alignment: .left
    )
    
    saveLabel.configure(
      font: .systemFont(ofSize: 8),
      color: .lightGray,
      lineNumber: 1,
      alignment: .left
    )
    
    configureStack()
    
    travelImageView.clipsToBounds = true
    travelImageView.layer.cornerRadius = 20
    
    let image = UIImage(systemName: Constant.Symbol.heart)
    likeButton.setImage(image, for: .normal)
  }
  
  func setData(data: Travel) {
    guard
      let title = data.title,
      let description = data.description,
      let grade = data.grade,
      let reviewCount = data.reviewCount,
      let save = data.save,
      let like = data.like
    else {
      CityError.log(path: #function + #line.description, error: .travelDataNotFound)
      return
    }
    
    setStars(grade: grade)
    
    titleLabel.text = title
    descLabel.text = description
    saveLabel.text = "(\(reviewCount)) · 저장 \(save)"
  }
  
  private func configureStack() {
    starStackView.axis = .horizontal
    starStackView.distribution = .fillEqually
    starStackView.spacing = 2
  }
  
  private func setStars(grade: Double) {
    let starCount: Int = Int(grade * 2)
    let fullStarCount: Int = starCount / 2
    let halfStarCount: Int = starCount % 2
    let noStarCount: Int = starCount - fullStarCount - halfStarCount
    
    if fullStarCount > 0 {
      for i in 0..<fullStarCount {
        let imageView: UIImageView = starImageViews[i]
        imageView.image = UIImage(systemName: Constant.Symbol.starFill)?.configured(color: .yellow)
      }
    }
    
    if halfStarCount > 0 {
      for i in 0..<halfStarCount {
        let imageView: UIImageView = starImageViews[i]
        imageView.image = UIImage(systemName: Constant.Symbol.starLeadinghalfFilled)?.configured(color: .yellow)
      }
    }
    
    if noStarCount > 0 {
      for i in 0..<halfStarCount {
        let imageView: UIImageView = starImageViews[i]
        imageView.image = UIImage(systemName: Constant.Symbol.starFill)?.configured(color: .lightGray)
      }
    }
  }
}
