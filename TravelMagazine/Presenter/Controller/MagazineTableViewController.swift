//
//  TripleTableViewController.swift
//  TravelMagazine
//
//  Created by 원태영 on 1/8/24.
//

import UIKit

final class MagazineTableViewController: UITableViewController {
  
  @IBOutlet weak var headerImageView: UIImageView!
  @IBOutlet weak var headerTitleLabel: UILabel!
  
  private let magazineInfo = MagazineInfo()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureUI()
  }
  
  // MARK: - TableViewDelegate
  override func tableView(
    _ tableView: UITableView,
    numberOfRowsInSection section: Int
  ) -> Int {
    return magazineInfo.magazine.count
  }
  
  override func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    /**
     스토리보드에 정의한 Cell의 identifier를 "a"로 설정하고, 코드로 구현한 TripleTableViewCell의 identifier를 "b"로 register 한다.
     
     이 상태에서 스토리보드 Cell과 TripleTableViewCell을 연결하면?
     
     - 동작 순서는 [identifier a 설정 == 스토리보드와 코드 Cell 연결] => identifier b register
     - 두 Cell이 연결되어있다고 해서 a를 b가 덮어쓰지는 않는다.
     - a를 호출하면 스토리보드 레이아웃과 코드 로직이 모두 적용된 Cell이 재사용되지만, b를 호출하면 코드베이스에서 설정한 레이아웃이 적용된다. => b는 UITableView에 적용된 기본 레이아웃이 사용된다.
     */
    let cell: TripleTableViewCell
    let identifider = String(describing: TripleTableViewCell.self)
    let magazine = magazineInfo.magazine[indexPath.row]
    
    if let dequeueCell = tableView.dequeueReusableCell(withIdentifier: identifider) as? TripleTableViewCell {
      cell = dequeueCell
    } else {
      MagazineError.log(path: #function + #line.description, error: .registeredCellNotFound)
      cell = TripleTableViewCell()
    }
    
    // Cell 설정 로직을 ViewController에서 가지게되면, 저 Cell을 재사용하는 다른 ViewController가 생겼을 때, 설정 로직을 다시 구현해야하는 문제점이 발생함
    configureCell(cell, magazine: magazine)
    
    return cell
  }
}

extension MagazineTableViewController: Navigator {
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let magazine: Magazine = magazineInfo.magazine[indexPath.row]
    
    push(WebViewController.self) { controller in
      controller.setData(data: magazine)
    }
    
    tableView.reloadRows(at: [indexPath], with: .automatic)
  }
}

// MARK: - Configure UI
extension MagazineTableViewController {
  private func configureUI() {
    tableView.separatorStyle = .none
    setImageView(headerImageView)
    setLabel(headerTitleLabel)
  }
  
  private func setImageView(_ imageView: UIImageView) {
    let image = UIImage(systemName	: "ellipsis")?.configured(size: 8, color: .systemGray2)
    
    imageView.image = image
  }
  
  private func setLabel(_ label: UILabel) {
    label.text = "SeSAC TRAVEL"
    label.font = .boldSystemFont(ofSize: 16)
    label.textAlignment = .center
  }
}

// MARK: - Configure Cell
extension MagazineTableViewController {
  enum LabelStyle {
    case title
    case subtitle
    case date
  }

  private func configureCell(_ cell: TripleTableViewCell, magazine: Magazine) {
    setCellImageView(cell.cityImageView, url: magazine.url)
    setCellLabel(cell.titleLabel, text: magazine.title, style: .title)
    setCellLabel(cell.subtitleLabel, text: magazine.subtitle, style: .subtitle)
    setCellLabel(cell.dateLabel, text: magazine.date.formattedDate.formattedString, style: .date)
  }
  
  private func setCellImageView(_ imageView: UIImageView, url: URL?) {
    let placeholder = UIImage(systemName: "photo")?.configured(color: .black)
    imageView.kf.setImage(with: url, placeholder: placeholder)
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    imageView.layer.cornerRadius = 15
  }

  private func setCellLabel(_ label: UILabel, text: String, style: LabelStyle) {
    label.text = text
    
    switch style {
      case .title:
        label.font = .systemFont(ofSize: 22, weight: .heavy)
        label.textColor = .darkGray
        label.textAlignment = .left
        label.numberOfLines = 2
        
      case .subtitle:
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .gray
        label.textAlignment = .left
        
      case .date:
        label.font = .systemFont(ofSize: 12)
        label.textColor = .gray
        label.textAlignment = .right
    }
  }
}
