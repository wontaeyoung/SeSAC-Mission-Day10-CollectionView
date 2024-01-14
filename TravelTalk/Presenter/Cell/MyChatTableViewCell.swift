//
//  MyChatTableViewCell.swift
//  TravelTalk
//
//  Created by 원태영 on 1/13/24.
//

import UIKit

final class MyChatTableViewCell: UITableViewCell {
  
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
  
  override func prepareForReuse() {
    hideDateChangedView()
  }
}

// MARK: - Configure
extension MyChatTableViewCell: CellDataSettable {
  func configureCell() {
    messageLabel.configure(text: nil,
                           font: .systemFont(ofSize: Constant.FontSize.message),
                           color: .label,
                           lineNumber: 0,
                           alignment: .left)
    messageBubbleView.setCornerRadius(radius: 8, border: (color: .gray, width: 1))
    messageBubbleView.backgroundColor = .systemGray5
    
    timeLabel.configure(text: nil,
                        font: .systemFont(ofSize: Constant.FontSize.date),
                        color: .gray,
                        lineNumber: 1,
                        alignment: .left)
    
    dateChangedView.setCornerRadius(radius: 8)
    dateChangedView.backgroundColor = .dateChagnedBackground
  }
  
  func setData(data: Chat, tag: Int) {
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
}
