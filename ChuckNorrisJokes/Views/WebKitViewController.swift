//
//  WebKitViewController.swift
//  ChuckNorrisJokes
//
//  Created by Анастасия Кудашева on 20.01.2021.
//

import UIKit
import WebKit

class WebKitViewController: UIViewController, WKNavigationDelegate {
	@IBOutlet weak var webView: WKWebView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.loadRequest()
	}
}

private extension WebKitViewController {
	func loadRequest() {
		guard let url = URL(string: "http://www.icndb.com/api/") else {
			self.showErrorAlert(.failUrl)
			return
		}
		let request = URLRequest(url: url)
		self.webView.load(request)
		self.webView.navigationDelegate = self
	}

	func showErrorAlert(_ error: NetworkError) {
		let alertController = UIAlertController(title: nil,
												message: error.humanFriendlyMessage,
												preferredStyle: .alert)
		let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
		alertController.addAction(alertAction)
		self.present(alertController, animated: true)
	}
}
