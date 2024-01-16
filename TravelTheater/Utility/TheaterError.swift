//
//  TheaterError.swift
//  TravelTheater
//
//  Created by 원태영 on 1/15/24.
//

import Foundation

enum TheaterError: LocalizedError {
  case theaterFilterInvalid
  case castingAnnotationFailed
  
  var errorDescription: String {
    switch self {
      case .theaterFilterInvalid:
        return "유효하지 않은 영화관 이름입니다."
        
      case .castingAnnotationFailed:
        return "해당 핀 위치로 이동하는데 실패했습니다."
    }
  }
}
