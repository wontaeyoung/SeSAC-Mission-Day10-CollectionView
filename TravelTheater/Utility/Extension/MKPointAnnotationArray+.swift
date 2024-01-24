//
//  MKPointAnnotationArray+.swift
//  TravelTheater
//
//  Created by 원태영 on 1/16/24.
//

import MapKit

/// Distance가 아니라 Center - 가장 멀리있는 핀 사이에 위도차, 경도차로 span 만들기
extension Array where Element == MKAnnotation {
  var denominator: CLLocationDegrees {
    return CLLocationDegrees(self.count)
  }
  
  var centerLatitude: CLLocationDegrees {
    return self.reduce(0) { $0 + $1.coordinate.latitude } / denominator
  }
  
  var centerLongitude: CLLocationDegrees {
    return self.reduce(0) { $0 + $1.coordinate.longitude } / denominator
  }
  
  var centerCoordinate: CLLocationCoordinate2D {
    return CLLocationCoordinate2D(latitude: centerLatitude, longitude: centerLongitude)
  }
  
  var centerLocation: CLLocation {
    return CLLocation(latitude: centerLatitude, longitude: centerLongitude)
  }
  
  var maxDistance: CLLocationDegrees {
    var maxDistance: CLLocationDegrees = .zero
    
    self.forEach { pin in
      let distance: CLLocationDistance = pin.location.distance(from: centerLocation)
      
      maxDistance = Swift.max(maxDistance, distance)
    }
    
    return maxDistance
  }
  
  var bufferedMaxDistance: CLLocationDegrees {
    return maxDistance * 2 + 3000
  }
  
  var centerSpan: MKCoordinateSpan {
    return MKCoordinateSpan(
      latitudeDelta: bufferedMaxDistance / Constant.Map.decimalDegrees,
      longitudeDelta: bufferedMaxDistance / Constant.Map.decimalDegrees
    )
  }
}

extension MKAnnotation {
  var location: CLLocation {
    return CLLocation(latitude: self.coordinate.latitude, longitude: self.coordinate.longitude)
  }
}
