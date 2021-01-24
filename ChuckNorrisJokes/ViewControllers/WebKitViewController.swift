//
//  WebKitViewController.swift
//  ChuckNorrisJokes
//
//  Created by Анастасия Кудашева on 20.01.2021.
//

import UIKit
import WebKit

class WebKitViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var webKitAPI: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "http://www.icndb.com/api/")
        let request = URLRequest(url: url!)
        webKitAPI.load(request)
        
        webKitAPI.navigationDelegate = self
    }
    
}
