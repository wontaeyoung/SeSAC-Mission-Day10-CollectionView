//
//  ChatRoomViewController.swift
//  TravelTalk
//
//  Created by 원태영 on 1/13/24.
//

import UIKit

final class ChatRoomViewController: UIViewController {
  
  @IBOutlet weak var chatTableView: UITableView!
  @IBOutlet weak var messageTextView: UITextView!
  
  private var chatRoom: ChatRoom = .dummy
  private var chats: [Chat] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    register(cellType: MyChatTableViewCell.self)
    register(cellType: OtherChatTableViewCell.self)
    configureTableView()
  }
}

extension ChatRoomViewController: Navigatable {
  func setData(data: ChatRoom) {
    self.chatRoom = data
    self.chats = data.chats
  }
}

// MARK: - Table Protocol
extension ChatRoomViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return chats.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let row: Int = indexPath.row
    let chat: Chat = chats[safe: row] ?? .dummy
    
    if chat.isMine {
      let cell = tableView.dequeueCell(type: MyChatTableViewCell.self, indexPath: indexPath)
      cell.setData(data: chat, tag: row)
      
      return cell
    } else {
      let cell = tableView.dequeueCell(type: OtherChatTableViewCell.self, indexPath: indexPath)
      cell.setData(data: chat, tag: row)
      
      return cell
    }
  }
}

// MARK: - Configure
extension ChatRoomViewController: TableUIConfigurable {
  func register<T: CellConfigurable>(cellType: T.Type) {
    let xib = UINib(nibName: cellType.identifier, bundle: nil)
    
    chatTableView.register(xib, forCellReuseIdentifier: cellType.identifier)
  }
  
  func configureTableView() {
    chatTableView.delegate = self
    chatTableView.dataSource = self
    chatTableView.separatorStyle = .none
  }
  
  func configureUI() { }
}
