//
//  Theater.swift
//  TravelTheater
//
//  Created by 원태영 on 1/15/24.
//

import MapKit

struct Theater {
  let type: String
  let location: String
  let latitude: Double
  let longitude: Double
  
  var theaterType: TheaterType {
    return TheaterType(rawValue: type) ?? .all
  }
  
  var coordinate: CLLocationCoordinate2D {
    return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
  }
  
  var region: MKCoordinateRegion {
    return MKCoordinateRegion(center: coordinate, latitudinalMeters: 50000, longitudinalMeters: 50000)
  }
}

enum TheaterType: String, CaseIterable {
  case lotte = "롯데시네마"
  case mega = "메가박스"
  case cgv = "CGV"
  case all = "모두"
  
  var name: String {
    return self.rawValue
  }
}
