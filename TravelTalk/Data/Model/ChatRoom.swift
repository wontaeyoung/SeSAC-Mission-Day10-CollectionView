//
//  ChatRoom.swift
//  TravelTalk
//
//  Created by 원태영 on 1/12/24.
//

import Foundation

struct ChatRoom: Model {
  let id: Int
  let images: [String]
  let name: String
  var chats: [Chat] = []
  
  var lastMessage: String {
    guard let lastChat = chats.last else {
      
    }
    return chats.last
  }
}
