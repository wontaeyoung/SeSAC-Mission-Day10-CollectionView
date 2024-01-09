//
//  ViewController.swift
//  SeSAC-Mission-Day10-CollectionView
//
//  Created by 원태영 on 1/9/24.
//

import UIKit

enum DomesticFilter {
  case all
  case domestic
  case international
}

final class ViewController: UIViewController {
  
  @IBOutlet weak var headerView: HeaderView!
  @IBOutlet weak var domesticSegment: UISegmentedControl!
  @IBOutlet weak var cityCollectionView: UICollectionView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    headerView.configureUI()
  }
}

