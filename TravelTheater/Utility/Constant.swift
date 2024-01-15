//
//  Constant.swift
//  TravelTheater
//
//  Created by 원태영 on 1/15/24.
//

import UIKit

enum Constant {
  enum Map {
    static let radiusMeter: Double = 15000
    static let filteredRadiusMeter: Double = 10000
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
  
  enum Label: String {
    case filterAlertTitle = "영화관 선택하기"
    
    var text: String {
      return self.rawValue
    }
  }
  
  enum SFSymbol: String {
    case filterBarButton = "line.3.horizontal.decrease.circle"
    
    var image: UIImage? {
      return UIImage(systemName: self.rawValue)
    }
  }
}
