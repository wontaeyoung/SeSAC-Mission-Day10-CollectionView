//
//  TripleError.swift
//  SeSAC-Mission-Day9-Triple
//
//  Created by 원태영 on 1/8/24.
//

enum TripleError: Error {
  case registeredCellNotFound
  case typeToDateFailed
  
  var errorDescription: String {
    switch self {
      case .registeredCellNotFound:
        return "식별자로 등록된 셀을 찾을 수 없습니다."
        
      case .typeToDateFailed:
        return "지정된 날짜 형식과 일치하지 않습니다."
    }
  }
}

extension TripleError {
  static func log(path: String, error: TripleError) {
    print(path, error.errorDescription)
  }
}
