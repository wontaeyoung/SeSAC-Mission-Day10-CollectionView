//
//  Magazine.swift
//  TravelMagazine
//
//  Created by 원태영 on 1/8/24.
//

import Foundation

struct Magazine {
  let title: String
  let subtitle: String
  let photoImage: String
  let date: String
  let link: String
  
  var url: URL? {
    return URL(string: photoImage)
  }
}
