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
  
}

// MARK: - Core Location Manager Delegate
extension LocationManager: CLLocationManagerDelegate {
  
  /// 권한 설정 변경 감지
  func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
    
  }
}
