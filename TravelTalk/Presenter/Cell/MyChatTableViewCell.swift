//
//  MyChatTableViewCell.swift
//  TravelTalk
//
//  Created by 원태영 on 1/13/24.
//

import UIKit

final class MyChatTableViewCell: UITableViewCell {
  
  @IBOutlet weak var messageLabel: UILabel!
  @IBOutlet weak var timeLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    configureCell()
  }
}

// MARK: - Configure
extension MyChatTableViewCell: CellDataSettable {
  func configureCell() {
    messageLabel.configure(text: nil,
                               font: .systemFont(ofSize: 14),
                               color: .label,
                               lineNumber: 0,
                               alignment: .left)
    
    timeLabel.configure(text: nil,
                        font: .systemFont(ofSize: 12),
                        color: .gray,
                        lineNumber: 1,
                        alignment: .left)
  }
  
  func setData(data: Chat, tag: Int) {
    messageLabel.text = data.message
    timeLabel.text = data.chatTimeFormatted
  }
}
