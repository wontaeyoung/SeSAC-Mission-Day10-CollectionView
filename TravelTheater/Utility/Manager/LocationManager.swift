//
//  LocationManager.swift
//  TravelTheater
//
//  Created by 원태영 on 1/24/24.
//

import CoreLocation

final class LocationManager: NSObject {
  
  static let shared = LocationManager()
  private let manager = CLLocationManager()
  weak var delegate: LocationManagerDelegate?
  
  /// 델리게이트 설정
  override private init() {
    super.init()
    
    self.manager.delegate = self
  }
}

// MARK: - 위치 서비스 & 권한 요청
extension LocationManager {
  
  /// 사용자의 현재 위치 좌표를 요청합니다.
  func requestCurrentLocation() {
    manager.requestLocation()
  }
  
  func checkLocationAuthorization() {
    
    /// 위치 서비스가 설정에서 OFF로 되어있으면 안내 후 앱 종료
    DispatchQueue.global().async { [weak self] in
      guard let self else { return }
      
      guard locationServiceEnabled else {
        delegate?.showLocationServiceTurnOffAlert()
        return
      }
      
      authorizationAction(with: currentAuthorization)
    }
  }
  
  /// 현재 사용자의 위치 서비스 글로벌 설정 상태를 반환합니다.
  private var locationServiceEnabled: Bool {
    return CLLocationManager.locationServicesEnabled()
  }
  
  /// 현재 TravelTheater 서비스의 위치 권한 상태를 반환합니다.
  var currentAuthorization: CLAuthorizationStatus {
    
    if #available(iOS 14.0, *) {
      return manager.authorizationStatus
    } else {
      return CLLocationManager.authorizationStatus()
    }
  }
  
  /// 권한 상태를 받아서 필요한 액션을 수행합니다.
  private func authorizationAction(with status: CLAuthorizationStatus) {
    
    switch status {
      case .notDetermined:
        manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        manager.requestWhenInUseAuthorization()
      
      case .denied:
        let coordinateValue = Constant.Location.sesacYeongdeungpo.coordinateValue
        let destination = CLLocationCoordinate2D(
          latitude: coordinateValue.x,
          longitude: coordinateValue.y
        )
        
        delegate?.updateCoordinateOnMap(coordiante: destination)
        delegate?.showPermissionRequestAlert()
        
      case .authorizedWhenInUse:
        /// requestCurrentLocation은 startUpdatingLocation 상태에서는 작동하지 않음
        /// 1회성으로 요청하는 로직과 실시간 트래킹 로직이 상반되기 때문에 그런 것 같음
        /// updating이 아닌 상태에서 start를 해야 트리거로 현재 위치를 한 번 받아오기 때문에 stop -> start 형태로 구성
        manager.stopUpdatingLocation()
        manager.startUpdatingLocation()
        
      default:
        fatalError("정의되지 않은 권한입니다.")
    }
  }
}

// MARK: - Core Location Manager Delegate
extension LocationManager: CLLocationManagerDelegate {
  
  /// 권한 설정 변경 감지
  func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
    checkLocationAuthorization()
  }
  
  /// 위치 획득 성공
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    
    guard let coordinate = locations.last?.coordinate else {
      print("현재 위치 좌표를 획득하는데 실패했습니다.")
      return
    }
    
    delegate?.updateCoordinateOnMap(coordiante: coordinate)
  }
  
  /// 위치 획득 실패
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    
    print("위치 획득 실패", error.localizedDescription)
  }
}
