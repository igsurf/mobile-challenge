//
//  WebViewController.swift
//  DesafioSafra
//
//  Created by Renato Ferraz on 29/04/21.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    @IBOutlet weak var viewWeb: UIView!
    @IBOutlet weak var progress: UIActivityIndicatorView!

    var webView: WKWebView!
    
    var urlString : String!{
        didSet{
            let myBlog = urlString
            let request = URL(string: myBlog!)
            webView = WKWebView(frame: self.view.frame)
            webView.navigationDelegate = self
            webView.load(URLRequest(url: request!))
            webView.allowsBackForwardNavigationGestures = true
            self.viewWeb.addSubview(webView)
        }
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            progress.style = .large
        } else {
            progress.style = .whiteLarge
        }
        
        progress.isHidden = false
        progress.startAnimating()
    }
    
    @IBAction func Close(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension WebViewController: WKNavigationDelegate{
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        progress.stopAnimating()
        progress.isHidden = true
    }
    
}
