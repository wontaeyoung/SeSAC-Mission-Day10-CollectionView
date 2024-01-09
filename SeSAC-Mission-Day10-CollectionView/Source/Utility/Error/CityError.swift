//
//  CityError.swift
//  SeSAC-Mission-Day10-CollectionView
//
//  Created by 원태영 on 1/9/24.
//

enum CityError: Error {
  case invalidFilterSegment
  
  var errorDescription: String {
    switch self {
      case .invalidFilterSegment:
        return "유효하지 않은 필터 세그먼트입니다."
    }
  }
  
  static func log(path: String, error: CityError) {
    print(path, error.errorDescription)
  }
}
