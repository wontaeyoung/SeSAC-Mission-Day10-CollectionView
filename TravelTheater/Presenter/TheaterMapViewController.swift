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
      resetMapAnnotation()
      setMapAnnotation()
    }
  }
  
  private var startCoordinate: CLLocationCoordinate2D {
    let coordValue: (x: Double, y: Double) = Constant.Location.nodeulStation.coordinateValue
    
    return CLLocationCoordinate2D(latitude: coordValue.x, longitude: coordValue.y)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureMap()
    setMapAnnotation()
    setFilterBarButtonItem()
  }
  
  private func updateTheaters() {
    self.theaters = TheaterList.filteredAnnotations[currentFilter]
  }
}

// MARK: - Navigation Bar
extension TheaterMapViewController {
  private func setFilterBarButtonItem() {
    let image = Constant.SFSymbol.filterBarButton.image?.configured(size: 20, color: .darkGray)
    let button: UIBarButtonItem = UIBarButtonItem(image: image,
                                                  style: .plain,
                                                  target: self,
                                                  action: #selector(filterBarButtonTapped))
    navigationItem.rightBarButtonItem = button
  }
  
  @objc private func filterBarButtonTapped() {
    showingFilterActionSheet()
  }
  
  private func showingFilterActionSheet() {
    let alert = UIAlertController(title: Constant.Label.filterAlertTitle.text,
                                  message: nil,
                                  preferredStyle: .actionSheet)
    
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
  private func configureMap() {
    let region = MKCoordinateRegion(center: startCoordinate,
                                    latitudinalMeters: Constant.Map.radiusMeter,
                                    longitudinalMeters: Constant.Map.radiusMeter)
    mapView.setRegion(region, animated: true)
  }
  
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
  }
  
  private func resetMapAnnotation() {
    mapView.removeAnnotations(mapView.annotations)
  }
}
