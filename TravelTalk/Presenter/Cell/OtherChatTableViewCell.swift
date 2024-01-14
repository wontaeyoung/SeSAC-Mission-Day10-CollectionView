//
//  OtherChatTableViewCell.swift
//  TravelTalk
//
//  Created by 원태영 on 1/13/24.
//

import UIKit

final class OtherChatTableViewCell: UITableViewCell {
  
  @IBOutlet weak var profileImageView: UIImageView!
  @IBOutlet weak var userNameLabel: UILabel!
  @IBOutlet weak var messageLabel: UILabel!
  @IBOutlet weak var messageBubbleView: UIView!
  @IBOutlet weak var timeLabel: UILabel!
  
  @IBOutlet weak var dateChangedView: UIView!
  @IBOutlet weak var dateChangedLabel: UILabel!
  @IBOutlet weak var dateChangedViewHeightConstraint: NSLayoutConstraint!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    configureCell()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    profileImageView.circleShape()
  }
  
  /// prepare에서 hide 해주지 않으면 재사용 Cell의 제약사항이 다른 Cell에 영향을 미침
  override func prepareForReuse() {
    hideDateChangedView()
  }
}

// MARK: - Configure
extension OtherChatTableViewCell: CellDataSettable {
  func configureCell() {
    configureImageView()
    
    userNameLabel.configure(text: nil,
                            font: .systemFont(ofSize: 14),
                            color: .label,
                            lineNumber: 1,
                            alignment: .left)
    
    messageLabel.configure(text: nil,
                           font: .systemFont(ofSize: Constant.FontSize.message),
                           color: .label,
                           lineNumber: 0,
                           alignment: .left)
    
    messageBubbleView.setCornerRadius(radius: 8, border: (color: .gray, width: 1))
    
    timeLabel.configure(text: nil,
                        font: .systemFont(ofSize: Constant.FontSize.date),
                        color: .gray,
                        lineNumber: 1,
                        alignment: .left)
    
    dateChangedView.setCornerRadius(radius: 8)
    dateChangedView.backgroundColor = .dateChagnedBackground
  }
  
  func setData(data: Chat, tag: Int) {
    profileImageView.image = UIImage(named: data.user.name)
    userNameLabel.text = data.user.name
    messageLabel.text = data.message
    timeLabel.text = data.chatTimeFormatted
  }
  
  func showDateChangedView(date: String) {
    dateChangedViewHeightConstraint.constant = 30
    dateChangedLabel.configure(text: date,
                               font: .boldSystemFont(ofSize: 12),
                               color: .darkGray,
                               lineNumber: 1,
                               alignment: .center)
  }
  
  private func hideDateChangedView() {
    dateChangedViewHeightConstraint.constant = .zero
  }
  
  private func configureImageView() {
    profileImageView.contentMode = .scaleAspectFit
  }
}
