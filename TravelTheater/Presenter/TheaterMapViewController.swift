//
//  TheaterMapViewController.swift
//  TravelTheater
//
//  Created by 원태영 on 1/15/24.
//

import UIKit
import MapKit

// TODO: -
/// 1. 지도 핀 좌표 평균값 구해서 center 위치 구하기
/// 2. center에서 가장 먼 distance 핀 거리로 반지름 구해서 span 적용하기

final class TheaterMapViewController: UIViewController {
  
  @IBOutlet weak var mapView: MKMapView!
  
  private var theaters: [Theater]? = TheaterList.mapAnnotations
  private var currentFilter: TheaterType = .all {
    didSet {
      updateTheaters()
      resetMapAnnotation()
      setMapAnnotation()
    }
  }
  
  /// 현재 영화관 필터가 all이면 전체가 보이는 반경으로, 아니라면 확대된 반경을 반환합니다.
  private var mapRadiusMeter: Double {
    return currentFilter == .all ? Constant.Map.radiusMeter : Constant.Map.filteredRadiusMeter
  }
  
  /// 기본(노들역)으로 설정된 좌표를 반환합니다.
  private var startCoordinate: CLLocationCoordinate2D {
    let coordValue: (x: Double, y: Double) = Constant.Location.nodeulStation.coordinateValue
    
    return CLLocationCoordinate2D(latitude: coordValue.x, longitude: coordValue.y)
  }
  
  /// 1. 델리게이트 설정
  /// 2. 핀 포인트 생성
  /// 3. 시작 위치 설정
  /// 4. 필터 Bar 버튼 추가
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setDelegate()
    setMapAnnotation()
    configureMap()
    setFilterBarButtonItem()
  }
  
  /// 현재 필터 타입에 해당하는 영화관 리스트를 반영합니다.
  private func updateTheaters() {
    self.theaters = TheaterList.filteredAnnotations[currentFilter]
  }
}

// MARK: - Navigation Bar
extension TheaterMapViewController {
  /// 네비게이션 바 우측에 필터 버튼을 추가합니다.
  private func setFilterBarButtonItem() {
    let image = Constant.SFSymbol.filterBarButton.image?.configured(size: 20, color: .label)
    let button: UIBarButtonItem = UIBarButtonItem(image: image,
                                                  style: .plain,
                                                  target: self,
                                                  action: #selector(filterBarButtonTapped))
    navigationItem.rightBarButtonItem = button
  }
  
  @objc private func filterBarButtonTapped() {
    showingFilterActionSheet()
  }
  
  /// 액션 시트를 호출합니다.
  private func showingFilterActionSheet() {
    let alert = UIAlertController(title: Constant.Text.filterAlertTitle.text,
                                  message: nil,
                                  preferredStyle: .actionSheet)
    
    /// 선택된 액션에 해당하는 영화관 필터 타입으로 현재 필터를 교체합니다.
    let actions: [UIAlertAction] = TheaterType.allCases.map { type in
      return UIAlertAction(title: type.name, style: .default) { _ in
        self.currentFilter = type
      }
    }
    
    actions.forEach { action in
      alert.addAction(action)
    }
    
    present(alert, animated: true)
  }
}

// MARK: - Configure Map
extension TheaterMapViewController {
  /// 지도의 표시 위치를 설정합니다. 목적지를 받았으면 해당 목적지로, 아니라면 전체 영화관의 중간 위치를 계산해서 설정합니다.
  private func configureMap(destination: MKCoordinateRegion? = nil) {
    let region = destination ?? MKCoordinateRegion(
      center: mapView.annotations.centerCoordinate,
      span: mapView.annotations.centerSpan
    )
    
    mapView.setRegion(region, animated: true)
  }
  
  /// 영화관 데이터 배열을 통해 위치를 계산해서 핀 포인트를 설치합니다.
  private func setMapAnnotation() {
    guard let theaters else {
      print(#function, TheaterError.theaterFilterInvalid.errorDescription)
      return
    }
    
    let annotations: [MKPointAnnotation] = theaters.map { theater in
      let annotation = MKPointAnnotation()
      annotation.coordinate = theater.coordinate
      annotation.title = theater.location
      
      return annotation
    }
    
    mapView.addAnnotations(annotations)
    configureMap(destination: nil)
  }
  
  /// 핀 포인트의 위치로 현재 위치를 이동시킵니다.
  private func moveToDestination(_ annotation: MKPointAnnotation?) {
    if let annotation {
      let newRegion = MKCoordinateRegion(center: annotation.coordinate,
                                         latitudinalMeters: Constant.Map.selectedRadiusMeter,
                                         longitudinalMeters: Constant.Map.selectedRadiusMeter)
      configureMap(destination: newRegion)
    }
  }
  
  /// 모든 핀 포인트를 제거합니다.
  private func resetMapAnnotation() {
    mapView.removeAnnotations(mapView.annotations)
  }
}

// MARK: - Map Delegate
extension TheaterMapViewController: MKMapViewDelegate {
  /// 맵뷰 델리게이트를 설정합니다.
  private func setDelegate() {
    mapView.delegate = self
  }
  
  /// 핀 포인트가 탭 되면 호출됩니다. 목적지로 이동하는 함수를 호출합니다.
  func mapView(_ mapView: MKMapView, didSelect annotation: MKAnnotation) {
    guard let casted = annotation as? MKPointAnnotation else {
      print(#function, TheaterError.castingAnnotationFailed.errorDescription)
      return
    }
    
    moveToDestination(casted)
  }
  
  /// 영화관 로고 이미지를 핀 포인트에 적용합니다.
  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    guard 
      let annotation = annotation as? MKPointAnnotation,
      let theaterTitle = annotation.title?.firstWord,
      let theaterType = TheaterType(rawValue: theaterTitle)
    else {
      return nil
    }
    
    let annotationView = MKAnnotationView()
    
    annotationView.annotation = annotation
    annotationView.image = theaterType.annotationImage.resized(newWidth: 40)
    annotationView.canShowCallout = true
    
    return annotationView
  }
}
