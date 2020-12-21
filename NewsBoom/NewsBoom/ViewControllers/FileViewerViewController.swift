//
//  FileViewerViewController.swift
//  NewsBoom
//
//  Created by Apple on 21/12/20.
//

import Foundation
import WebKit
class FileViewerViewController: UIViewController, WKNavigationDelegate {
    @IBOutlet var lblTitle:UILabel!
    @IBOutlet var webView:WKWebView!
    public var fileURL:String!
    public var headerTitle:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        lblTitle.text = headerTitle;
        webView.navigationDelegate = self;
        if let resourceUrl = URL(string: fileURL) {
                let request = URLRequest(url: resourceUrl)
            showSpinner(onView: self.view)
                webView.load(request)
                
            }
    }
    
    func webView(_ webView: WKWebView,didFinish navigation: WKNavigation!) { print("loaded")
        removeSpinner(onView: self.view)
    }

}
