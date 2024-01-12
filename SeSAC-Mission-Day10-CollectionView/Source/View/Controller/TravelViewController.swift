//
//  TravelViewController.swift
//  SeSAC-Mission-Day10-CollectionView
//
//  Created by 원태영 on 1/11/24.
//

import UIKit

final class TravelViewController: UIViewController {
  
  @IBOutlet weak var travelTableView: UITableView!
  
  private var travels: [Travel] = TravelInfo().travel
  static let identifier: String = Constant.Identifier.travelViewController
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    register()
    configureUI()
    configureTableView()
  }
  
  @objc private func likeButtonTapped(_ sender: UIButton) {
    travels[sender.tag].like?.toggle()
    travelTableView.reloadRows(
      at: [IndexPath(row: sender.tag, section: .zero)],
      with: .automatic
    )
  }
}

// MARK: - Table Configure UI
extension TravelViewController: TableUIConfigurable {
  func register() {
    let travelXib = UINib(nibName: TravelTableViewCell.identifier, bundle: nil)
    travelTableView.register(travelXib, forCellReuseIdentifier: TravelTableViewCell.identifier)
    
    let adXib = UINib(nibName: ADTableViewCell.identifier, bundle: nil)
    travelTableView.register(adXib, forCellReuseIdentifier: ADTableViewCell.identifier)
  }
  
  func configureUI() {
    navigationItem.title = Constant.Label.cityDetailInfoTitle
  }
  
  func configureTableView() {
    travelTableView.delegate = self
    travelTableView.dataSource = self
  }
}

// MARK: - Table Protocol
extension TravelViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    travels.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let row: Int = indexPath.row
    let travel: Travel = travels[row]
    let dataSetCell: any CellDataSettable
    
    if travel.ad {
      let cell = tableView.dequeueReusableCell(withIdentifier: ADTableViewCell.identifier, for: indexPath) as! ADTableViewCell
      cell.setData(data: travel, tag: row)
      
      dataSetCell = cell
    } else {
      let cell = tableView.dequeueReusableCell(withIdentifier: TravelTableViewCell.identifier, for: indexPath) as! TravelTableViewCell
      cell.setData(data: travel, tag: row)
      cell.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
      
      dataSetCell = cell
    }
    
    return dataSetCell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let controller = storyboard?.instantiateViewController(withIdentifier: Constant.Identifier.travelDetailViewController) as! TravelDetailViewController
    
    let travel: Travel = travels[indexPath.row]
    
    controller.isAD = travel.ad
    
    if travel.ad {
      present(controller, style: .fullScreen)
    } else {
      push(controller)
    }
  }
}
