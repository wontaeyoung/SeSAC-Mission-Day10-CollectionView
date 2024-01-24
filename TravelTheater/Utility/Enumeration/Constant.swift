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
    static let selectedRadiusMeter: Double = 2000
    static let decimalDegrees: Double = 111319.5
  }
  
  enum Location {
    case nodeulStation
    case sesacYeongdeungpo
    
    var coordinateValue: (Double, Double) {
      switch self {
        case .nodeulStation:
          return (37.512466, 126.953748)
          
        case .sesacYeongdeungpo:
          return (37.517742, 126.886463)
      }
    }
  }
  
  enum Text: String {
    case filterAlertTitle = "영화관 선택하기"
    
    var text: String {
      return self.rawValue
    }
  }
  
  enum SFSymbol: String {
    case filterBarButton = "line.3.horizontal.decrease.circle"
    case currentLocationButton = "dot.scope"
    
    var image: UIImage? {
      return UIImage(systemName: self.rawValue)
    }
  }
  
  enum Image {
    static let cgv: UIImage = .cgvLogo
    static let lotteCinema: UIImage = .lotteCinemaLogo
    static let megaBox: UIImage = .megaBoxLogo
  }
}
