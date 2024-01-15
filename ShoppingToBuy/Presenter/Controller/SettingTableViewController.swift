//
//  SettingTableViewController.swift
//  SeSAC-Mission-Day8-TableView
//
//  Created by 원태영 on 1/5/24.
//

import UIKit

final class SettingTableViewController: UITableViewController {
  enum Section: Int, CaseIterable {
    case all
    case personal
    case etc
    
    var headerTitle: String {
      switch self {
        case .all:
          return "전체 설정"
          
        case .personal:
          return "개인 설정"
          
        case .etc:
          return "기타"
      }
    }
  }
  
  let cellTitles: [[String]] = [
    ["공지사항", "실험실", "버전 정보"],
    ["개인/보안", "알림", "채팅", "멀티프로필"],
    ["고객센터/도움말"]
  ]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  // MARK: - Table view data source
  override func numberOfSections(in tableView: UITableView) -> Int {
    return Section.allCases.count
  }
  
  override func tableView(
    _ tableView: UITableView,
    numberOfRowsInSection section: Int
  ) -> Int {
    return cellTitles[section].count
  }
  
  override func tableView(
    _ tableView: UITableView,
    titleForHeaderInSection section: Int
  ) -> String? {
    return Section(rawValue: section)?.headerTitle
  }
  
  override func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettingTableViewCell") else {
      return .init()
    }
    let section: Int = indexPath.section
    let row: Int = indexPath.row
    
    cell.textLabel?.text = cellTitles[section][row]
    
    return cell
  }
  
  override func tableView(
    _ tableView: UITableView,
    heightForRowAt indexPath: IndexPath
  ) -> CGFloat {
    return 44
  }
}
