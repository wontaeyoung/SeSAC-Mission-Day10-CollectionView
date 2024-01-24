//
//  String+.swift
//  TravelTheater
//
//  Created by 원태영 on 1/24/24.
//

extension String {
  static func combineWithLineBreaks(_ strings: String...) -> Self {
    return strings.joined(separator: "\n")
  }
  
  var firstWord: String {
    guard self.contains(" ") else {
      return self
    }
    
    return self.components(separatedBy: " ").first!
  }
}
