//
//  UIViewController+.swift
//  TravelTalk
//
//  Created by 원태영 on 1/12/24.
//

import UIKit

extension UIViewController {
  func push(_ controller: UIViewController) {
    navigationController?.pushViewController(controller, animated: true)
  }
}

