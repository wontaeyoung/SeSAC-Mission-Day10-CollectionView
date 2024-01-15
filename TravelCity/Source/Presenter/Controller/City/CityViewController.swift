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
  
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var domesticSegment: UISegmentedControl!
  @IBOutlet weak var cityCollectionView: UICollectionView!
  
  private var cityList: [City] = DomesticFilter.all.cityList {
    didSet {
      cityCollectionView.reloadData()
    }
  }
  
  private var currentFilter: DomesticFilter? {
    return DomesticFilter(rawValue: domesticSegment.selectedSegmentIndex)
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
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    print(#function, cityList.count)
  }
  
  @objc private func segmentChanged(_ sender: UISegmentedControl) {
    updateCityList()
  }
  
  private func segmentedCityList(filterCase: DomesticFilter?) -> [City] {
    guard 
      let filterCase,
      let cityList = CityInfo.cityDictionary[filterCase]
    else {
      CityError.log(path: #function + #line.description, error: .invalidFilterSegment)
      return []
    }
    
    return cityList
  }
  
  private func updateCityList() {
    let segmentedCityList: [City] = segmentedCityList(filterCase: currentFilter)
    let searchKeyword: String = searchBar.text!.lowercased()
    
    guard !searchKeyword.isEmpty else {
      self.cityList = segmentedCityList
      return
    }
    
    segmentedCityList.forEach {
      print($0.name, $0.searchKeywordContains(text: searchKeyword))
    }
    
    self.cityList = segmentedCityList.filter {
      $0.searchKeywordContains(text: searchKeyword)
    }
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
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let storyboard = UIStoryboard(name: Constant.Storyboard.travel, bundle: nil)
    let controller = storyboard.instantiateViewController(withIdentifier: TravelViewController.identifier)
    
    navigationController?.pushViewController(controller, animated: true)
  }
}

// MARK: - Configure
extension CityViewController: CollectionUIConfigurable {
  func register() {
    let xib = UINib(nibName: CityCollectionViewCell.identifier, bundle: nil)
    cityCollectionView.register(xib, forCellWithReuseIdentifier: CityCollectionViewCell.identifier)
  }
  
  func configureUI() {
    configureSearchBar()
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
  
  private func configureSearchBar() {
    searchBar.searchBarStyle = .minimal
    searchBar.placeholder = Constant.Label.searchingCityPlaceholder
    searchBar.delegate = self
    searchBar.searchTextField.delegate = self
  }
  
  private func configureView() {
    navigationItem.title = Constant.Label.headerTitle
    navigationController?.navigationBar.tintColor = .label
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

// MARK: - SearchBar Protocol
extension CityViewController: UISearchBarDelegate, UITextFieldDelegate {
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    updateCityList()
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    view.endEditing(true)
  }
  
  func searchBar(
    _ searchBar: UISearchBar,
    shouldChangeTextIn range: NSRange,
    replacementText text: String
  ) -> Bool {
    return text != " "
  }
}
