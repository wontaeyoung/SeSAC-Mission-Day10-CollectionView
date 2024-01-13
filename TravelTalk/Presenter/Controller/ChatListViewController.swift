//
//  ChatListViewController.swift
//  TravelTalk
//
//  Created by 원태영 on 1/12/24.
//

import UIKit

final class ChatListViewController: UIViewController {
  
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var chatRoomTableView: UITableView!
  
  private var chatRooms: [ChatRoom] = mockChatList
  
  override func viewDidLoad() {
    super.viewDidLoad()
    register(cellType: ChatTableViewCell.self)
    configureTableView()
  }
}

extension ChatListViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return chatRooms.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: ChatTableViewCell = tableView.dequeueReusableCell(
      withIdentifier: ChatTableViewCell.identifier,
      for: indexPath
    ) as! ChatTableViewCell
    let row: Int = indexPath.row
    let chatRoom: ChatRoom = chatRooms[safe: row] ?? .dummy
    
    cell.setData(data: chatRoom, tag: row)
    
    return cell
  }
}

extension ChatListViewController: TableUIConfigurable {
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
