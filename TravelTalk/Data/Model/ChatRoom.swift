//
//  ChatRoom.swift
//  TravelTalk
//
//  Created by 원태영 on 1/12/24.
//

import UIKit

struct ChatRoom: Model {
  // MARK: - Property
  let id: Int
  let images: [String]
  let name: String
  var chats: [Chat] = []
  
  // MARK: - Method
  var firstImage: UIImage? {
    guard
      let imageAssetName = images.first,
      let image = UIImage(named: imageAssetName)
    else {
      ErrorManager.log(path: #function + #line.description, error: ChatRoomError.imageUnfindable)
      
      return nil
    }
    
    return image
  }
  
  var lastMessage: String {
    guard let lastChat = chats.last else {
      ErrorManager.log(path: #function + #line.description, error: ChatRoomError.emptyChatList)
      
      return ""
    }
    
    return lastChat.message
  }
  
  var lastMessageCreateAt: String {
    guard let lastChat = chats.last else {
      ErrorManager.log(path: #function + #line.description, error: ChatRoomError.emptyChatList)
      
      return ""
    }
    
    return lastChat.chatRoomDateFormatted
  }
  
  var joinUser: User {
    let users: [User] = chats
      .map { $0.user }
      .filter { $0 != .user }
    
    return users.randomElement()!
  }
  
  // MARK: - Static
  static var dummyID: Int = 10000
  
  static var dummy: ChatRoom {
    dummyID += 1
    
    return ChatRoom(id: dummyID,
                    images: [],
                    name: "더미")
  }
}
