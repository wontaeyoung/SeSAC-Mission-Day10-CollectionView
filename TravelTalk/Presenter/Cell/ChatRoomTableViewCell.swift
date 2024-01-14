//
//  ChatRoomTableViewCell.swift
//  TravelTalk
//
//  Created by 원태영 on 1/12/24.
//

import UIKit

final class ChatRoomTableViewCell: UITableViewCell {
  
  @IBOutlet weak var profileImageView: UIImageView!
  @IBOutlet weak var userNameLabel: UILabel!
  @IBOutlet weak var lastMessageLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  
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
extension ChatRoomTableViewCell: CellDataSettable {
  func configureCell() {
    configureImageView()
    
    userNameLabel.configure(text: nil,
                            font: .boldSystemFont(ofSize: 15),
                            color: .label,
                            lineNumber: 1,
                            alignment: .left)
    
    lastMessageLabel.configure(text: nil,
                               font: .systemFont(ofSize: Constant.FontSize.message),
                               color: .gray,
                               lineNumber: 1,
                               alignment: .left)
    
    dateLabel.configure(text: nil,
                        font: .systemFont(ofSize: Constant.FontSize.date),
                        color: .gray,
                        lineNumber: 1,
                        alignment: .right)
  }
  
  func setData(data: ChatRoom, tag: Int) {
    profileImageView.image = data.firstImage
    userNameLabel.text = data.name
    lastMessageLabel.text = data.lastMessage
    dateLabel.text = data.lastMessageCreateAt
  }
  
  private func configureImageView() {
    profileImageView.contentMode = .scaleAspectFit
  }
}
