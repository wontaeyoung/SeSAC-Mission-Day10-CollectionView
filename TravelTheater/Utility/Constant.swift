//
//  Constant.swift
//  TravelTheater
//
//  Created by 원태영 on 1/15/24.
//

import Foundation

enum Constant {
  enum Map {
    static let radiusMeter: Double = 15000
  }
  
  enum Location {
    case seoulStation
    
    var coordinateValue: (Double, Double) {
      switch self {
        case .seoulStation:
          return (37.554921, 126.970345)
      }
    }
  }
}
