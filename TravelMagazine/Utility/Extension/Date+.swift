//
//  Date+.swift
//  TravelMagazine
//
//  Created by 원태영 on 1/8/24.
//

import Foundation

extension Date {
  var formattedString: String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yy년 MM월 dd일"
    
    return formatter.string(from: self)
  }
}
