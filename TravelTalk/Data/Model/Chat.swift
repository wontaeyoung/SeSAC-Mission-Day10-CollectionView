//
//  Chat.swift
//  TravelTalk
//
//  Created by 원태영 on 1/12/24.
//

struct Chat: Model {
  let user: User
  let date: String
  let message: String
  
  var chatRoomDateFormatted: String {
    date.formatted(format: Constant.DateFormat.chatListDateFormat)
  }
  
  var chatDetailDateFormatted: String {
    date.formatted(format: Constant.DateFormat.chatRoomDateFormat)
  }
  
  var chatTimeFormatted: String {
    date.formatted(format: Constant.DateFormat.chatRoomTimeFormat)
  }
}
