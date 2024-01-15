//
//  UIViewController+.swift
//  TravelTalk
//
//  Created by 원태영 on 1/15/24.
//

import UIKit

extension UIViewController {
  func setKeyboardObserver() {
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(UIViewController.keyboardWillShow),
                                           name: UIResponder.keyboardWillShowNotification,
                                           object: nil)
  }
  
  @objc func keyboardWillShow(notification: NSNotification) {
    if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
      let keyboardRectangle = keyboardFrame.cgRectValue
      let keyboardHeight = keyboardRectangle.height
    }
  }
}
