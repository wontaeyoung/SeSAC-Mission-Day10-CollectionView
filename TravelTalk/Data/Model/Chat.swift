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
  
  var chatListDateFormatted: String {
    date.formatted(format: Constant.DateFormat.chatListDateFormat)
  }
  
  var chatRoomDateFormatted: String {
    date.formatted(format: Constant.DateFormat.chatRoomDateFormat)
  }
  
  var chatRoomTimeFormatted: String {
    date.formatted(format: Constant.DateFormat.chatRoomTimeFormat)
  }
}
