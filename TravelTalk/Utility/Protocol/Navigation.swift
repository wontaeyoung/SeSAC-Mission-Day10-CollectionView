//
//  Navigation.swift
//  TravelTalk
//
//  Created by 원태영 on 1/13/24.
//

import UIKit

protocol Navigator: UIViewController {
  func push<T: Navigatable>(_ type: T.Type, prepare: ((T) -> Void)?)
}

protocol Navigatable: UIViewController {
  associatedtype Entity: Model
  
  static var identifier: String { get }
  
  func setData(data: Entity, bindAction: (() -> Void)?)
}
