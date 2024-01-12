//
//  ChatRoom.swift
//  TravelTalk
//
//  Created by 원태영 on 1/12/24.
//

import Foundation

struct ChatRoom {
  let id: Int
  let images: [String]
  let name: String
  var chats: [Chat] = []
}
