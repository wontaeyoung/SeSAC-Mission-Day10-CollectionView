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
  @IBOutlet weak var timeLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    configureCell()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    profileImageView.circleShape()
  }
}

// MARK: - Configure
extension OtherChatTableViewCell: CellDataSettable {
  func configureCell() {
    configureImageView()
    
    userNameLabel.configure(text: nil,
                            font: .boldSystemFont(ofSize: 15),
                            color: .label,
                            lineNumber: 1,
                            alignment: .left)
    
    messageLabel.configure(text: nil,
                               font: .systemFont(ofSize: 14),
                               color: .gray,
                               lineNumber: 0,
                               alignment: .left)
    
    timeLabel.configure(text: nil,
                        font: .systemFont(ofSize: 12),
                        color: .gray,
                        lineNumber: 1,
                        alignment: .left)
  }
  
  func setData(data: Chat, tag: Int) {
    profileImageView.image = UIImage(named: data.user.name)
    userNameLabel.text = data.user.name
    messageLabel.text = data.message
    timeLabel.text = data.chatTimeFormatted
  }
  
  private func configureImageView() {
    profileImageView.contentMode = .scaleAspectFit
  }
}