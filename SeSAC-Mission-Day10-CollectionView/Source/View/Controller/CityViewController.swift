//
//  CityViewController.swift
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
  
  var cityList: [City] {
    return CityInfo.cityDictionary[self] ?? []
  }
}

final class CityViewController: UIViewController {
  
  @IBOutlet weak var domesticSegment: UISegmentedControl!
  @IBOutlet weak var cityCollectionView: UICollectionView!
  
  private var cityList: [City] = CityInfo.cityDictionary[DomesticFilter.all] ?? [] {
    didSet {
      cityCollectionView.reloadData()
    }
  }
  
  private var cellWidth: CGFloat {
    let cellCount: Int = Constant.CollectionView.cellCount
    let spacing: CGFloat = Constant.CollectionView.spacing
    let lineWidth: CGFloat = (UIScreen.main.bounds.width - (spacing * CGFloat(2 + cellCount - 1))) / CGFloat(cellCount)
    
    return lineWidth
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    register()
    configureUI()
    configureCollectionView()
  }
  
  @objc private func segmentChanged(_ sender: UISegmentedControl) {
    let domesticFilter = DomesticFilter(rawValue: sender.selectedSegmentIndex)
    filterCityList(filterCase: domesticFilter)
  }
  
  private func filterCityList(filterCase: DomesticFilter?) {
    guard let filterCase else {
      CityError.log(path: #function + #line.description, error: .invalidFilterSegment)
      return
    }
    
    self.cityList = filterCase.cityList
  }
}

// MARK: - CollectionView Protocol
extension CityViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    return cityList.count
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    let cell = cityCollectionView.dequeueReusableCell(
      withReuseIdentifier: CityCollectionViewCell.identifier,
      for: indexPath
    ) as! CityCollectionViewCell
    
    let city: City = cityList[indexPath.item]
    cell.configureCell(city: city)
    
    return cell
  }
}

// MARK: - Configure
extension CityViewController: CollectionUIConfigurable {
  func register() {
    let xib = UINib(nibName: CityCollectionViewCell.identifier, bundle: nil)
    cityCollectionView.register(xib, forCellWithReuseIdentifier: CityCollectionViewCell.identifier)
  }
  
  func configureUI() {
    configureView()
    setSegment()
  }
  
  func configureCollectionView() {
    let layout = UICollectionViewFlowLayout()
    let spacing = Constant.CollectionView.spacing
    let cellWidth = self.cellWidth
    
    layout.itemSize = CGSize(width: cellWidth, height: cellWidth + Constant.CollectionView.cellLabelFreeSpace)
    layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
    layout.minimumLineSpacing = spacing
    layout.minimumInteritemSpacing = spacing
    
    cityCollectionView.collectionViewLayout = layout
    cityCollectionView.delegate = self
    cityCollectionView.dataSource = self
  }
  
  private func configureView() {
    navigationItem.title = Constant.Label.headerTitle
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
