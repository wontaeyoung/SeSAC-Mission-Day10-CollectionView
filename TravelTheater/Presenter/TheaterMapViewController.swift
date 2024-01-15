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
  
  private var theaters: [Theater]? = TheaterList.mapAnnotations
  private var currentFilter: TheaterType = .all {
    didSet {
      updateTheaters()
      setMapAnntation()
    }
  }
  
  private var startCoordinate: CLLocationCoordinate2D {
    let coordValue: (x: Double, y: Double) = Constant.Location.nodeulStation.coordinateValue
    
    return CLLocationCoordinate2D(latitude: coordValue.x, longitude: coordValue.y)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureMap()
    setMapAnntation()
  }
  
  private func configureMap() {
    let region = MKCoordinateRegion(center: startCoordinate,
                                    latitudinalMeters: Constant.Map.radiusMeter,
                                    longitudinalMeters: Constant.Map.radiusMeter)
    mapView.setRegion(region, animated: true)
  }
  
  private func updateTheaters() {
    self.theaters = TheaterList.filteredAnnotations[currentFilter]
  }
  
  private func setMapAnntation() {
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
  }
}
