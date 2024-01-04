//
//  ViewController.swift
//  Project4
//
//  Created by gayeugur on 27.11.2023.
//

import UIKit
import WebKit

class ViewController: UIViewController{

    //MARK: @IBOUTLET
    @IBOutlet weak var webView: WKWebView!
    
    //MARK: PROPERTIES
    var progressView: UIProgressView!
    var websites = ["apple.com", "hackingwithswift.com"]
    
    //MARK: LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        initProgressBar()
        showSites()
        setup()
    }
    
    //MARK: PRIVATE FUNCTION
    private func setup() {
        webView.navigationDelegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: progressView)
        webView.allowsBackForwardNavigationGestures = true
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
    }
    
    private func showSites(action: UIAlertAction? = nil) {
        var urlStr: String
        
        if let actionTitle = action?.title, !actionTitle.isEmpty {
            urlStr = "https://" + actionTitle
        } else {
            urlStr = "https://" + websites[0]
        }
        
        let url = URL(string: urlStr)
        guard let url = url else { return }
        webView.load(URLRequest(url: url))
    }
    
    private func initProgressBar() {
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
    }
    
    //MARK: OBJC FUNCTION
    @objc func openTapped() {
        let alert = UIAlertController(title: "Open page", message: "Choose", preferredStyle: .actionSheet)
        for website in websites {
            alert.addAction(UIAlertAction(title: website, style: .default, handler: showSites))
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        present(alert, animated: true)
    }
    
}

//MARK: WKNAVIGATIONDELEGATE
extension ViewController: WKNavigationDelegate {
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
}
