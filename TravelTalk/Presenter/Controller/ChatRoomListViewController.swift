//
//  ChatRoomListViewController.swift
//  TravelTalk
//
//  Created by 원태영 on 1/12/24.
//

import UIKit

final class ChatRoomListViewController: UIViewController {
  
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var chatRoomTableView: UITableView!
  
  private var chatRooms: [ChatRoom] = ChatData.mockChatList
  
  override func viewDidLoad() {
    super.viewDidLoad()
    register(cellType: ChatRoomTableViewCell.self)
    configureTableView()
  }
}

// MARK: - Table Protocol
extension ChatRoomListViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return chatRooms.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: ChatRoomTableViewCell = tableView.dequeueReusableCell(
      withIdentifier: ChatRoomTableViewCell.identifier,
      for: indexPath
    ) as! ChatRoomTableViewCell
    let row: Int = indexPath.row
    let chatRoom: ChatRoom = chatRooms[safe: row] ?? .dummy
    
    cell.setData(data: chatRoom, tag: row)
    
    return cell
  }
}

// MARK: - Configure
extension ChatRoomListViewController: TableUIConfigurable {
  func register<T: CellConfigurable>(cellType: T.Type) {
    let xib = UINib(nibName: cellType.identifier, bundle: nil)
    
    chatRoomTableView.register(xib, forCellReuseIdentifier: cellType.identifier)
  }
  
  func configureTableView() {
    chatRoomTableView.delegate = self
    chatRoomTableView.dataSource = self
    chatRoomTableView.separatorStyle = .none
  }
  
  func configureUI() { }
}

// MARK: - Navigation
extension ChatRoomListViewController: Navigator {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    push(ChatRoomViewController.self)
    
    tableView.reloadRows(at: [indexPath], with: .automatic)
  }
}
