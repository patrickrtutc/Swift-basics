//
//  GoogleWebViewController.swift
//  FirstProject
//
//  Created by Patrick Tung on 2/18/25.
//

import UIKit
import WebKit

class GoogleWebViewController: UIViewController {
    
    @IBOutlet weak var googleWebView: WKWebView!
    
    private let url: URL = URL(string: "https://accounts.google.com/")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let preference = WKWebpagePreferences()
        preference.preferredContentMode = .mobile
        preference.allowsContentJavaScript = true
        
        let configuration = WKWebViewConfiguration()
        configuration.defaultWebpagePreferences = preference
        
        googleWebView.load(URLRequest(url: url))
    }
}
