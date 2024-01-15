//
//  WebViewController.swift
//  TravelMagazine
//
//  Created by 원태영 on 1/15/24.
//

import UIKit
import WebKit

final class WebViewController: UIViewController {
  
  private var magazine: Magazine? = nil
  
  @IBOutlet weak var webView: WKWebView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
   
    loadWebView(urlStr: magazine?.link)
  }
  
  private func loadWebView(urlStr: String?) {
    if let urlStr, let url = URL(string: urlStr) {
      let request: URLRequest = URLRequest(url: url)
      
      webView.load(request)
    }
  }
}

extension WebViewController: Navigatable {
  func setData(data: Magazine, bindAction: (() -> Void)? = nil) {
    self.magazine = data
  }
}
