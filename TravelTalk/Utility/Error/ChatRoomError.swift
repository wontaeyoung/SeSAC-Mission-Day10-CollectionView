//
//  ChatRoomError.swift
//  TravelTalk
//
//  Created by 원태영 on 1/12/24.
//

enum ChatRoomError: Error {
  case emptyChatList
  
  var description: String {
    switch self {
      case .emptyChatList:
        return "채팅 메세지가 비어있습니다."
    }
  }
}
