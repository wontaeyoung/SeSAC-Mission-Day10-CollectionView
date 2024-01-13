//
//  Navigation+.swift
//  TravelTalk
//
//  Created by 원태영 on 1/13/24.
//

import UIKit

extension Navigator {
  func push<T: Navigatable>(_ type: T.Type) {
    let controller: T = storyboard?.instantiateViewController(withIdentifier: type.identifier) as! T
    
    navigationController?.pushViewController(controller, animated: true)
  }
}

extension Navigatable {
  static var identifier: String {
   return String(describing: self)
  }
}
