//
//  ChatRoomError.swift
//  TravelTalk
//
//  Created by 원태영 on 1/12/24.
//

enum ChatRoomError: TravelErrorProtocol {
  case emptyChatList
  case imageUnfindable
  case chatRoomNotFound
  
  var description: String {
    switch self {
      case .emptyChatList:
        return "채팅 메세지가 비어있습니다."
        
      case .imageUnfindable:
        return "이미지를 찾을 수 없습니다."
        
      case .chatRoomNotFound:
        return "ID에 해당하는 채팅방을 찾을 수 없습니다."
    }
  }
}
