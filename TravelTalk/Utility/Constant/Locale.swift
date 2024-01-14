//
//  Locale.swift
//  TravelTalk
//
//  Created by 원태영 on 1/14/24.
//

import Foundation

enum TravelLocale: String {
  case kr = "ko_KR"
  
  var identifier: String {
    return self.rawValue
  }
  
  var locale: Locale {
    return Locale(identifier: self.identifier)
  }
}


