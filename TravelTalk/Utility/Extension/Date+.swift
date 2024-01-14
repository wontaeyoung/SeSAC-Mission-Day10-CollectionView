//
//  Date+.swift
//  TravelTalk
//
//  Created by 원태영 on 1/14/24.
//

import Foundation

extension Date {
  func string(format: String = "yyyy-MM-dd HH:mm") -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = format
    
    return formatter.string(from: self)
  }
}
