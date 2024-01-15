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
  @IBOutlet weak var messageInputTextViewHeightConstraint: NSLayoutConstraint!
  
  private var chatBotTimer: Timer?
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
  
  deinit {
    chatBotTimer?.invalidate()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    register(cellType: MyChatTableViewCell.self)
    register(cellType: OtherChatTableViewCell.self)
    configureTableView()
    configureUI()
    startTimer()
    
    messageSendButton.addTarget(self, action: #selector(messageSendButtonTapped), for: .touchUpInside)
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    self.scrollToBottom()
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

// MARK: - ChatBot
extension ChatRoomViewController {
  func startTimer() {
    self.chatBotTimer = Timer.scheduledTimer(timeInterval: 3,
                                      target: self,
                                      selector: #selector(addOtherChat),
                                      userInfo: nil,
                                      repeats: true)
  }
  
  @objc private func addOtherChat() {
    
    let newChat: Chat = Chat(user: chatRoom.joinUser,
                             date: Date.now.string(),
                             message: ChatData.greetings.randomElement()!)
    addChat(newChat)
    updateChatData(newChats: chats)
    scrollToBottom()
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
    messageInputTextView.showsVerticalScrollIndicator = false
    updateTextViewHeight()
    textViewDidEndEditing(messageInputTextView)
  }
  
  private func configureSendButton() {
    let image: UIImage? = UIImage(systemName: Constant.SFSymbol.paperplane)?.configured(color: .gray)
    messageSendButton.setImage(image, for: .normal)
    messageSendButton.isEnabled = false
  }
  
  private func setNavigationBar() {
    navigationController?.navigationBar.tintColor = .label
    navigationItem.title = chatRoom.name
  }
}

// MARK: - TextView Delegate
extension ChatRoomViewController: UITextViewDelegate {
  /// 텍스트 뷰의 텍스트가 변할 때마다 호출
  func textViewDidChange(_ textView: UITextView) {
    updateSendableButton()
    updateTextViewHeight()
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
  
  private func updateSendableButton() {
    let image: UIImage? = UIImage(systemName: sendButtonImageSymbol)?.configured(color: .gray)
    messageSendButton.setImage(image, for: .normal)
    messageSendButton.isEnabled = self.isSendable
  }
  
  private func updateTextViewHeight() {
    let size = CGSize(width: messageInputTextView.frame.width, height: .infinity)
    let estimatedSize = messageInputTextView.sizeThatFits(size)
    
    guard
      estimatedSize.height >= 30,
      estimatedSize.height <= 120
    else {
      return
    }
    
    messageInputTextViewHeightConstraint.constant = estimatedSize.height
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
    updateChatData(newChats: chats)
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
  
  private func updateChatData(newChats: [Chat]) {
    guard let currentChatRoomIndex else {
      ErrorManager.handle(controller: navigationController, error: ChatRoomError.chatRoomNotFound)
      return
    }
    
    ChatData.mockChatList[currentChatRoomIndex].chats = newChats
  }
}
