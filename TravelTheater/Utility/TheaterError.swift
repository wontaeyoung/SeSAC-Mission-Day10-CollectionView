//
//  TheaterError.swift
//  TravelTheater
//
//  Created by 원태영 on 1/15/24.
//

import Foundation

enum TheaterError: LocalizedError {
  case theaterFilterInvalid
  
  var errorDescription: String {
    switch self {
      case .theaterFilterInvalid:
        return "유효하지 않은 영화관 이름입니다."
    }
  }
}
