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
    case nodeulStation
    
    var coordinateValue: (Double, Double) {
      switch self {
        case .nodeulStation:
          return (37.512466, 126.953748)
      }
    }
  }
}
