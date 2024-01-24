//
//  LocationManagerDelegate.swift
//  TravelTheater
//
//  Created by 원태영 on 1/24/24.
//

import UIKit
import CoreLocation

protocol LocationManagerDelegate: UIViewController {
  func showLocationServiceTurnOffAlert()
  func showPermissionRequestAlert()
  func updateCoordinateOnMap(coordiante: CLLocationCoordinate2D)
}
