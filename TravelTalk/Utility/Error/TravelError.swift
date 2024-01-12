//
//  TravelError.swift
//  TravelTalk
//
//  Created by 원태영 on 1/12/24.
//

enum TravelError: TravelErrorProtocol {
  case navigationControllerUnfindable
  
  var description: String {
    switch self {
      case .navigationControllerUnfindable:
        return "네비게이션 컨트롤러를 찾을 수 없습니다."
    }
  }
}
