//
//  ToBuy.swift
//  SeSAC-Mission-Day8-TableView
//
//  Created by 원태영 on 1/5/24.
//

import Foundation

/**
 UserDefault는 우선적으로 기본형 타입만 지원한다.
 
 인코딩된 Data 타입을 저장할 때, [Data] 각 인스턴스를 인코딩한 배열을 저장하는 방법과 [ToBuy] -> Data로 변환해서 저장하는 방법이 있다.
 
 두 방법 모두 가능한데 편의성 측면에서는 반복문으로 인코딩 / 디코딩을 수행해야하는 1번 방법보다, 배열 자체를 Data로 변환하는것이 좋아보인다.
 
 각 인스턴스를 Data로 사용할만큼 유연성이 필요한 경우가 아니라면 2번 방법을 사용하자.
 */
struct ToBuy: Codable {
  let title: String
  var isCheck: Bool
  var isBookmark: Bool
  
  init(title: String) {
    self.title = title
    self.isCheck = false
    self.isBookmark = false
  }
}

extension UserDefaults {
  enum Key: String {
    case toBuy
    
    var name: String {
      return self.rawValue
    }
  }
}

@propertyWrapper
struct UserDefault<T: Codable> {
  private let key: UserDefaults.Key
  private var defaultValue: [T]
  
  init(
    key: UserDefaults.Key,
    defaultValue: [T] = []
  ) {
    self.key = key
    self.defaultValue = defaultValue
  }
  
  var wrappedValue: [T] {
    get {
      guard
        let data = UserDefaults.standard.data(forKey: key.name),
        let array = try? JSONDecoder().decode([T].self, from: data) 
      else {
        return defaultValue
      }
      
      return array
    }
    set {
      let data = try? JSONEncoder().encode(newValue)
      
      UserDefaults.standard.setValue(data, forKey: key.name)
    }
  }
}
