//
//  TheaterMapViewController.swift
//  TravelTheater
//
//  Created by 원태영 on 1/15/24.
//

import UIKit
import MapKit

final class TheaterMapViewController: UIViewController {
  
  @IBOutlet weak var mapView: MKMapView!
  
  private var theaters: [Theater] = TheaterList.mapAnnotations
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureMap()
  }
  
  private func configureMap() {
    let coordValue: (x: Double, y: Double) = Constant.Location.seoulStation.coordinateValue
    let coordinate = CLLocationCoordinate2D(latitude: coordValue.x, longitude: coordValue.y)
    let region = MKCoordinateRegion(center: coordinate,
                                    latitudinalMeters: Constant.Map.radiusMeter,
                                    longitudinalMeters: Constant.Map.radiusMeter)
    mapView.setRegion(region, animated: true)
  }
}
