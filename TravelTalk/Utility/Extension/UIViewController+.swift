//
//  UIViewController+.swift
//  TravelTalk
//
//  Created by 원태영 on 1/15/24.
//

import UIKit

extension UIViewController {
  @objc private func setKeyboardObserver() {
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(keyboardWillShow),
                                           name: UIResponder.keyboardWillShowNotification,
                                           object: nil)
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(keyboardWillHide),
                                           name: UIResponder.keyboardWillHideNotification,
                                           object: nil)
  }
  
  @objc private func keyboardWillShow(notification: NSNotification) {
//    guard let keyboard
    
    if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
      let keyboardRectangle = keyboardFrame.cgRectValue
      let keyboardHeight = keyboardRectangle.height
    }
  }
  
  @objc private func keyboardWillHide(notification: NSNotification) {
    
  }
  
}
