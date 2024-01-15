//
//  UIViewController+.swift
//  SeSAC-Mission-Day10-CollectionView
//
//  Created by 원태영 on 1/11/24.
//

import UIKit

extension UIViewController {
  func present(_ rootController: UIViewController, style: UIModalPresentationStyle) {
    let naviController = UINavigationController(rootViewController: rootController)
    naviController.modalPresentationStyle = style
    present(naviController, animated: true)
  }
  
  func push(_ controller: UIViewController) {
    navigationController?.pushViewController(controller, animated: true)
  }
}
