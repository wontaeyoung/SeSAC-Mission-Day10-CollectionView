//
//  TravelViewController.swift
//  SeSAC-Mission-Day10-CollectionView
//
//  Created by 원태영 on 1/11/24.
//

import UIKit

final class TravelViewController: UIViewController {
  
  @IBOutlet weak var travelTableView: UITableView!
  
  private let travelInfo = TravelInfo()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    register()
    configureUI()
    configureTableView()
  }
}

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

extension TravelViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    travelInfo.travel.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let travel: Travel = travelInfo.travel[indexPath.row]
    
    if travel.ad {
      let cell = tableView.dequeueReusableCell(withIdentifier: ADTableViewCell.identifier, for: indexPath) as! ADTableViewCell
      cell.setData(data: travel)
      
      return cell
    } else {
      let cell = tableView.dequeueReusableCell(withIdentifier: TravelTableViewCell.identifier, for: indexPath) as! TravelTableViewCell
      cell.setData(data: travel)
      
      return cell
    }
  }
}
