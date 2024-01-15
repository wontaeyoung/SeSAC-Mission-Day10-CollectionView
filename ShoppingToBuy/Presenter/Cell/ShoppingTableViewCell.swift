//
//  ShoppingTableViewCell.swift
//  SeSAC-Mission-Day8-TableView
//
//  Created by 원태영 on 1/5/24.
//

import UIKit

final class ShoppingTableViewCell: UITableViewCell {
  
  @IBOutlet weak var cellView: UIView!
  @IBOutlet weak var checkboxButton: UIButton!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var bookmarkButton: UIButton!
  
  var toBuy: ToBuy? {
    didSet {
      configureUI()
    }
  }
  
  var updateAction: ((ToBuy) -> Void)?
  
  private var checkboxSymbol: String {
    guard let toBuy else { return "checkmark.square" }
    
    return toBuy.isCheck ? "checkmark.square.fill" : "checkmark.square"
  }
  
  private var bookmarkSymbol: String {
    guard let toBuy else { return "star" }
    
    return toBuy.isBookmark ? "star.fill" : "star"
  }
  
  // MARK: - Method
  override func awakeFromNib() {
    super.awakeFromNib()
    
    configureUI()
  }
  
  @IBAction func toggleButtonTapped(_ sender: UIButton) {
    if sender == checkboxButton {
      toBuy?.isCheck.toggle()
      
      checkboxButton.setImage(UIImage(systemName: checkboxSymbol)?.colored(with: .label), for: .normal)
    } else {
      toBuy?.isBookmark.toggle()
      
      bookmarkButton.setImage(UIImage(systemName: bookmarkSymbol)?.colored(with: .label), for: .normal)
    }
    
    updateToBuys()
  }
  
  private func updateToBuys() {
    guard let toBuy else {
      print(#function, #line)
      return
    }
    
    self.updateAction?(toBuy)
  }
  
  private func configureUI() {
    guard let toBuy else { return }
    
    setView()
    setButton(checkboxButton, symbol: checkboxSymbol)
    setLabel(titleLabel, text: toBuy.title)
    setButton(bookmarkButton, symbol: bookmarkSymbol)
  }
  
  private func setView() {
    cellView.backgroundColor = .systemGray6
    cellView.layer.cornerRadius = 10
  }
  
  private func setButton(
    _ button: UIButton,
    symbol: String
  ) {
    let image: UIImage? = UIImage(systemName: symbol)?.colored(with: .label)
    button.setImage(image, for: .normal)
  }
  
  private func setLabel(
    _ label: UILabel,
    text: String
  ) {
    label.text = text
    label.font = .systemFont(ofSize: 14)
  }
}

extension UIImage {
  func colored(with color: UIColor) -> UIImage {
    return self.withTintColor(color, renderingMode: .alwaysOriginal)
  }
}
