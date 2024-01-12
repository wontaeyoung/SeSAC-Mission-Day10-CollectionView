//
//  String+.swift
//  TravelTalk
//
//  Created by 원태영 on 1/13/24.
//

import Foundation

extension String {
  func formatted(format: String) -> String {
    let formatter: DateFormatter = DateFormatter()
    formatter.dateFormat = format
    let date: Date = formatter.date(from: self) ?? .now
    
    return formatter.string(from: date)
  }
}
