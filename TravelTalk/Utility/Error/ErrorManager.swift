//
//  ErrorManager.swift
//  TravelTalk
//
//  Created by 원태영 on 1/12/24.
//

import UIKit

struct ErrorManager {
  static func log(path: String, error: TravelErrorProtocol) {
    print(path, error.description)
  }
  
  static func handle(controller: UINavigationController?, error: TravelErrorProtocol) {
    guard let controller else {
      log(path: #function + #line.description , error: TravelError.navigationControllerUnfindable)
      
      return
    }
    
    showErrorAlert(controller: controller, error: error)
  }
  
  static func showErrorAlert(
    controller: UINavigationController,
    error: TravelErrorProtocol
  ) {
    let alertController = UIAlertController(title: "오류 발생",
                                            message: error.description,
                                            preferredStyle: .alert)
    
    let okAction = UIAlertAction(title: "확인", style: .default)
    
    alertController.addAction(okAction)
    
    DispatchQueue.main.async {
      controller.present(alertController, animated: true)
    }
  }
}
