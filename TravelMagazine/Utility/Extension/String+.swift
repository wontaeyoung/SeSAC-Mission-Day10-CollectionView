//
//  String+.swift
//  TravelMagazine
//
//  Created by 원태영 on 1/8/24.
//

import Foundation

extension String {
  var formattedDate: Date {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyMMdd"
    
    guard let date = formatter.date(from: self) else {
      MagazineError.log(path: #function + #line.description, error: .typeToDateFailed)
      
      return Date.now
    }
    
    return date
  }
}
