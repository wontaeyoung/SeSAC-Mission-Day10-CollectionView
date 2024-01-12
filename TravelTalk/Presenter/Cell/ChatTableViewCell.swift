//
//  ChatTableViewCell.swift
//  TravelTalk
//
//  Created by 원태영 on 1/12/24.
//

import UIKit

final class ChatTableViewCell: UITableViewCell {
  
  @IBOutlet weak var profileImageView: UIImageView!
  @IBOutlet weak var userNameLabel: UILabel!
  @IBOutlet weak var lastMessageLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  
  static var identifier: String {
    return String(describing: self)
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    configureCell()
  }
}

extension ChatTableViewCell: CellDataSettable {
  
  func configureCell() {
    configureImageView()
    
    userNameLabel.configure(text: nil,
                            font: .boldSystemFont(ofSize: 16),
                            color: .label,
                            lineNumber: 1,
                            alignment: .left)
    
    lastMessageLabel.configure(text: nil,
                               font: .systemFont(ofSize: 16),
                               color: .gray,
                               lineNumber: 1,
                               alignment: .left)
    
    dateLabel.configure(text: nil,
                        font: .systemFont(ofSize: 12),
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
    profileImageView.contentMode = .scaleAspectFill
    profileImageView.clipsToBounds = true
  }
}
