//
//  Array+.swift
//  TravelTalk
//
//  Created by 원태영 on 1/12/24.
//

extension Array {
  subscript(safe index: Int) -> Element? {
    guard index < self.count else {
      return nil
    }
    
    return self[index]
  }
}
