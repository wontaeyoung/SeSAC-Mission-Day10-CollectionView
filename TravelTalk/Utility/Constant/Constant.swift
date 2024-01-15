//
//  Constant.swift
//  TravelTalk
//
//  Created by 원태영 on 1/13/24.
//

import Foundation

enum Constant {
  enum DateFormat {
    static let originDateFormat: String = "yyyy-MM-dd HH:mm"
    static let chatListDateFormat: String = "yy.MM.dd"
    static let chatRoomDateFormat: String = "yyyy년 MM월 dd일"
    static let chatRoomTimeFormat: String = "hh:mm a"
  }
  
  enum Label {
    static let userNameSearchFieldPlaceholder: String = "친구 이름을 검색해보세요"
    static let messageInputPlaceholder: String = "메세지를 입력하세요"
  }
  
  enum FontSize {
    static let name: CGFloat = 15
    static let message: CGFloat = 14
    static let date: CGFloat = 12
  }
  
  enum SFSymbol {
    static let chevronBackward: String = "chevron.backward"
    static let paperplane: String = "paperplane"
    static let paperplaneFill: String = "paperplane.fill"
  }
}
