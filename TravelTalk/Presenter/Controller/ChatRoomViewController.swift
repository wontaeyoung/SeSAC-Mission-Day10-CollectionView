//
//  ChatRoomViewController.swift
//  TravelTalk
//
//  Created by 원태영 on 1/13/24.
//

import UIKit

final class ChatRoomViewController: UIViewController {
  
  @IBOutlet weak var chatTableView: UITableView!
  @IBOutlet weak var messageFieldUIView: UIView!
  @IBOutlet weak var messageInputTextView: UITextView!
  @IBOutlet weak var messageSendButton: UIButton!
  
  private var chatRoom: ChatRoom = .dummy
  private var chats: [Chat] = []
  private var bindAction: (() -> Void)?
  
  private var isSendable: Bool {
    let text: String = messageInputTextView.text
    return !text.isEmpty && text != Constant.Label.messageInputPlaceholder
  }
  
  private var sendButtonImageSymbol: String {
    return self.isSendable ? Constant.SFSymbol.paperplaneFill : Constant.SFSymbol.paperplane
  }
  
  private var currentChatRoomIndex: Int? {
    return ChatData.mockChatList.firstIndex { chatRoom in
      chatRoom.id == self.chatRoom.id
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    register(cellType: MyChatTableViewCell.self)
    register(cellType: OtherChatTableViewCell.self)
    configureTableView()
    configureUI()
    
    messageSendButton.addTarget(self, action: #selector(messageSendButtonTapped), for: .touchUpInside)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    /// 레이아웃이 계산된 이후에 스크롤이 수행되도록 메인 스레드 작업 큐 끝으로 보내기
    DispatchQueue.main.async {
      self.scrollToBottom()
    }
  }
  
  @IBAction func endEditGestureTapped(_ sender: UITapGestureRecognizer) {
    view.endEditing(true)
  }
  
  private func scrollToBottom() {
    let lastRow: Int = chatTableView.numberOfRows(inSection: .zero) - 1
    let indexPath: IndexPath = IndexPath(row: lastRow, section: .zero)
    chatTableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
  }
}

// MARK: - Navigation
extension ChatRoomViewController: Navigatable {
  func setData(data: ChatRoom, bindAction: (() -> Void)? = nil) {
    self.chatRoom = data
    self.chats = data.chats
    self.bindAction = bindAction
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
    let isFirstCellOfNewDay: Bool = isFirstCellOfNewDay(currentDay: chat.chatDetailDateFormatted, row: row)
    
    if chat.isMine {
      let cell = tableView.dequeueCell(type: MyChatTableViewCell.self, indexPath: indexPath)
      cell.setData(data: chat, tag: row)
      if isFirstCellOfNewDay { cell.showDateChangedView(date: chat.chatDetailDateFormatted) }
      
      return cell
    } else {
      let cell = tableView.dequeueCell(type: OtherChatTableViewCell.self, indexPath: indexPath)
      cell.setData(data: chat, tag: row)
      if isFirstCellOfNewDay { cell.showDateChangedView(date: chat.chatDetailDateFormatted) }
      
      return cell
    }
  }
  
  private func isFirstCellOfNewDay(currentDay: String, row: Int) -> Bool {
    guard row > 0 else {
      return true
    }
    
    let previousDay: String = chats[safe: row - 1]?.chatDetailDateFormatted ?? currentDay
    print("current", currentDay, "pre", previousDay)
    if currentDay != previousDay {
      print("새로운 날짜 \(row)")
    }
    
    return currentDay != previousDay
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
    chatTableView.allowsSelection = false
  }
  
  func configureUI() {
    configureFieldBackground()
    configureTextView()
    configureSendButton()
    setNavigationBar()
  }
  
  private func configureFieldBackground() {
    messageFieldUIView.setCornerRadius(radius: 5, border: nil)
    messageFieldUIView.backgroundColor = .systemGray6
  }
  
  private func configureTextView() {
    messageInputTextView.delegate = self
    messageInputTextView.backgroundColor = .clear
    messageInputTextView.autocorrectionType = .no
    messageInputTextView.autocapitalizationType = .none
    textViewDidEndEditing(messageInputTextView)
  }
  
  private func configureSendButton() {
    let image: UIImage? = UIImage(systemName: Constant.SFSymbol.paperplane)?.configured(color: .gray)
    messageSendButton.setImage(image, for: .normal)
    messageSendButton.isEnabled = false
  }
  
  private func setNavigationBar() {
    navigationController?.navigationBar.tintColor = .black
    navigationItem.title = chatRoom.name
  }
}

// MARK: - TextView Delegate
extension ChatRoomViewController: UITextViewDelegate {
  /// 텍스트 뷰의 텍스트가 변할 때마다 호출
  func textViewDidChange(_ textView: UITextView) {
    let image: UIImage? = UIImage(systemName: sendButtonImageSymbol)?.configured(color: .gray)
    messageSendButton.setImage(image, for: .normal)
    messageSendButton.isEnabled = self.isSendable
  }
  
  /// 텍스트 뷰 편집을 시작할 때, 커서가 생기는 시점
  func textViewDidBeginEditing(_ textView: UITextView) {
    if textView.textColor == .lightGray {
      textView.text = ""
      textView.textColor = .label
    }
  }
  
  /// 텍스트 뷰 편집이 종료될 때, 커서가 없어지는 시점
  func textViewDidEndEditing(_ textView: UITextView) {
    if textView.text.isEmpty {
      textView.text = "메세지를 입력하세요"
      textView.textColor = .lightGray
    }
  }
}

// MARK: - Message Adding
extension ChatRoomViewController {
  @objc private func messageSendButtonTapped(_ sender: UIButton) {
    let message: String = messageInputTextView.text
    let newChat: Chat = Chat(user: .user, date: Date.now.string(), message: message)
    
    view.endEditing(true)
    addChat(newChat)
    clearMessageField()
    scrollToBottom()
    
    guard let currentChatRoomIndex else {
      ErrorManager.handle(controller: navigationController, error: ChatRoomError.chatRoomNotFound)
      return
    }
    
    updateChatData(index: currentChatRoomIndex, newChats: chats)
    bindAction?()
  }
  
  private func addChat(_ newChat: Chat) {
    chats.append(newChat)
    chatTableView.reloadData()
  }
  
  private func clearMessageField() {
    messageInputTextView.text = nil
    textViewDidChange(messageInputTextView)
    textViewDidEndEditing(messageInputTextView)
  }
  
  private func updateChatData(index: Int, newChats: [Chat]) {
    ChatData.mockChatList[index].chats = newChats
  }
}
