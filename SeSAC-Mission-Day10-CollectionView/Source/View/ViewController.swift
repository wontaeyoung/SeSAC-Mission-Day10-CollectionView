//
//  ViewController.swift
//  SeSAC-Mission-Day10-CollectionView
//
//  Created by 원태영 on 1/9/24.
//

import UIKit

enum DomesticFilter: Int, CaseIterable {
  case all
  case domestic
  case international
  
  var name: String {
    switch self {
      case .all:
        return "모두"
        
      case .domestic:
        return "국내"
        
      case .international:
        return "해외"
    }
  }
}

final class ViewController: UIViewController {
  
  @IBOutlet weak var headerView: HeaderView!
  @IBOutlet weak var domesticSegment: UISegmentedControl!
  @IBOutlet weak var cityCollectionView: UICollectionView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    headerView.configureUI()
    configureUI()
  }
  
  @objc private func segmentChanged(_ sender: UISegmentedControl) {
    print(sender.selectedSegmentIndex)
  }
}

// MARK: - Configure UI
extension ViewController {
  private func configureUI() {
    setSegment()
  }
  
  private func setSegment() {
    let items: [DomesticFilter] = DomesticFilter.allCases
    
    // First, Second 삭제
    domesticSegment.removeAllSegments()
    
    // 모두, 국내, 해외를 Segment에 추가하기
    items.enumerated().forEach { (index, item) in
      domesticSegment.insertSegment(withTitle: item.name, at: index, animated: true)
    }
    
    // 시작 Segment 번호를 0으로 설정
    domesticSegment.selectedSegmentIndex = .zero
    
    // segment 수정 시 segmentChanged 함수가 호출되도록 연결
    domesticSegment.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
  }
}

