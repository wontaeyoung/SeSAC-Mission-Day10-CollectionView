//
//  ChatRoom.swift
//  TravelTalk
//
//  Created by 원태영 on 1/12/24.
//

import UIKit

struct ChatRoom: Model {
  let id: Int
  let images: [String]
  let name: String
  var chats: [Chat] = []
  
  var firstImage: UIImage? {
    guard
      let imageAssetName = images[safe: 0],
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
}
