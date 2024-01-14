//
//  String+.swift
//  TravelTalk
//
//  Created by 원태영 on 1/13/24.
//

import Foundation

extension String {
  func formatted(format: String, travelLocale: TravelLocale? = nil) -> String {
    let formatter: DateFormatter = DateFormatter()
    formatter.dateFormat = Constant.DateFormat.originDateFormat
    formatter.locale = travelLocale?.locale
    
    let date: Date = formatter.date(from: self) ?? .now
    formatter.dateFormat = format
    
    return formatter.string(from: date)
  }
}
