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
    @IBOutlet var viewBG:UIView!
    //@IBOutlet var webView:WKWebView!
    public var fileURL:String!
    public var headerTitle:String!
    var webView: WKWebView!
    var activityIndicator:UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        lblTitle.text = headerTitle;
        activityIndicator = UIActivityIndicatorView.init(style: .gray)
        activityIndicator.center = self.view.center;
        
        let webConfig = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfig)
        self.viewBG = webView
        webView.navigationDelegate = self;
        activityIndicator.hidesWhenStopped = true;
        self.view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        if let resourceUrl = URL(string: fileURL) {
                let request = URLRequest(url: resourceUrl)
                //showSpinner(onView: self.view)
                webView.load(request)
        }
    }
    
    func webView(_ webView: WKWebView,didFinish navigation: WKNavigation!) { print("loaded")
        removeSpinner(onView: self.view)
        activityIndicator.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        removeSpinner(onView: self.view)
        activityIndicator.stopAnimating()
    }

}
