//
//  TravelTableViewCell.swift
//  SeSAC-Mission-Day10-CollectionView
//
//  Created by 원태영 on 1/11/24.
//

import UIKit

final class TravelTableViewCell: UITableViewCell {
  
  typealias Entity = Travel
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var descLabel: UILabel!
  @IBOutlet weak var starStackView: UIStackView!
  @IBOutlet var starImageViews: [UIImageView]!
  @IBOutlet weak var saveLabel: UILabel!
  @IBOutlet weak var travelImageView: UIImageView!
  @IBOutlet weak var likeButton: UIButton!
  
  static let identifier: String = "TravelTableViewCell"
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    configureCell()
  }
}

// MARK: - Configure Cell
extension TravelTableViewCell: CellDataSettable {
  func configureCell() {
    titleLabel.configure(
      font: .boldSystemFont(ofSize: 16),
      alignment: .left
    )
    
    descLabel.configure(
      font: .systemFont(ofSize: 14),
      color: .darkGray,
      lineNumber: 0,
      alignment: .left
    )
    
    saveLabel.configure(
      font: .boldSystemFont(ofSize: 12),
      color: .lightGray,
      lineNumber: 1,
      alignment: .left
    )
    
    selectionStyle = .none
    configureStack()
    configureImageView()
  }
  
  func setData(data: Travel, tag: Int) {
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
    configureButton(isLike: like)
    likeButton.tag = tag
    
    titleLabel.text = title
    descLabel.text = description
    saveLabel.text = "(\(reviewCount.demicalNumberFormatted)) · 저장 \(save.demicalNumberFormatted)"
    travelImageView.kf.setImage(with: data.url)
  }
  
  private func configureStack() {
    starStackView.axis = .horizontal
    starStackView.distribution = .fillEqually
    starStackView.spacing = 2
  }
  
  private func configureImageView() {
    travelImageView.contentMode = .scaleAspectFill
    travelImageView.clipsToBounds = true
    travelImageView.layer.cornerRadius = 20
  }
  
  private func configureButton(isLike: Bool) {
    let symbol: String = isLike ? Constant.Symbol.heartFill : Constant.Symbol.heart
    let image = UIImage(systemName: symbol)?.configured(size: 20, color: .white)
    likeButton.setImage(image, for: .normal)
  }
  
  private func setStars(grade: Double) {
    let starCount: Int = Int(grade * 2)
    let fullStarCount: Int = starCount / 2
    let halfStarCount: Int = starCount % 2
    let noStarCount: Int = starCount - fullStarCount - halfStarCount
    
    if fullStarCount > 0 {
      for i in 0..<fullStarCount {
        let imageView: UIImageView = starImageViews[i]
        imageView.image = UIImage(systemName: Constant.Symbol.starFill)?.configured(color: .star)
      }
    }
    
    if halfStarCount > 0 {
      for i in fullStarCount..<fullStarCount + halfStarCount {
        let imageView: UIImageView = starImageViews[i]
        imageView.image = UIImage(systemName: Constant.Symbol.starLeadinghalfFilled)?.configured(color: .star)
      }
    }
    
    if noStarCount > 0 {
      for i in fullStarCount + halfStarCount..<starImageViews.count {
        let imageView: UIImageView = starImageViews[i]
        imageView.image = UIImage(systemName: Constant.Symbol.starFill)?.configured(color: .systemGray6)
      }
    }
  }
}
