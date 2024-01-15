//
//  TravelDetailViewController.swift
//  SeSAC-Mission-Day10-CollectionView
//
//  Created by 원태영 on 1/11/24.
//

import UIKit

final class TravelDetailViewController: UIViewController {
  
  @IBOutlet weak var titleLabel: UILabel!
  var isAD: Bool?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureUI()
    setData()
  }
 
  @objc private func dismissButtonTapped() {
    dismiss(animated: true)
  }
}

// MARK: - Configure UI
extension TravelDetailViewController: UIConfigurable {
  func configureUI() {
    titleLabel.configure(
      font: .systemFont(ofSize: 32, weight: .black),
      alignment: .center
    )
  }
  
  func setData() {
    guard let isAD else {
      CityError.log(path: #function + #line.description, error: .travelDataNotFound)
      return
    }
    
    if isAD {
      setTitle(Constant.Label.adTitle)
      setBarButtonItem()
    } else {
      setTitle(Constant.Label.travelDetailTitle)
    }
  }
  
  private func setTitle(_ title: String) {
    navigationItem.title = title
    titleLabel.text = title
  }
  
  private func setBarButtonItem() {
    let image = UIImage(systemName: Constant.Symbol.xmark)?.configured(color: .black)
    
    let dismissButton = UIBarButtonItem(
      image: image,
      style: .plain,
      target: self,
      action: #selector(dismissButtonTapped)
    )
    
    navigationItem.rightBarButtonItem = dismissButton
  }
}
