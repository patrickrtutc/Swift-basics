//
//  FacebookWebViewController.swift
//  FirstProject
//
//  Created by Patrick Tung on 2/18/25.
//

import UIKit
import WebKit

class FacebookWebViewController: UIViewController {
    
    @IBOutlet weak var facebookWebView: WKWebView!
    
    private let url: URL = URL(string: "https://www.facebook.com/")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let preference = WKWebpagePreferences()
        preference.preferredContentMode = .mobile
        preference.allowsContentJavaScript = true
        
        let configuration = WKWebViewConfiguration()
        configuration.defaultWebpagePreferences = preference
        
        facebookWebView.load(URLRequest(url: url))
    }
}
