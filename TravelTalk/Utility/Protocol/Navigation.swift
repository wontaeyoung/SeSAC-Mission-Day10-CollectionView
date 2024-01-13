//
//  Navigation.swift
//  TravelTalk
//
//  Created by 원태영 on 1/13/24.
//

import UIKit

protocol Navigator: UIViewController {
  func push<T: Navigatable>(_ type: T.Type)
}

protocol Navigatable: UIViewController {
  static var identifier: String { get }
}
