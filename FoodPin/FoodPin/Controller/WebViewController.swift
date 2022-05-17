//
//  WebViewController.swift
//  FoodPin
//
//  Created by Andreea Sburlea on 16.05.2022.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    @IBOutlet private var webView: WKWebView!
    var targetURL = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        if let url = URL(string: targetURL) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}
