//
//  ViewController.swift
//  WebKitHistoryBug
//
//  Created by Arnold Goldberg on 3/9/21.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    @IBOutlet weak var containerView: UIView?
    @IBOutlet weak var backButton: UIButton?
    @IBOutlet weak var retainWebViewSwitch: UISwitch!
    
    private var retainWebView = false
    private var webView: WKWebView?
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    private func removeAndRecreateWebView() {
        if !retainWebView {
            webView?.removeFromSuperview()
            self.webView = nil
        }
        
        if webView == nil {
            let wv = WKWebView(frame: CGRect(x: 0.0, y: 0.0, width: containerView?.frame.width ?? 0.0, height: containerView?.frame.height ?? 0.0))
            containerView?.addSubview(wv)
            self.webView = wv
        }
    }
    
    @IBAction func goBack(sender: UIButton){
        webView?.evaluateJavaScript("window.history.back();") { _, _ in
        }
    }
    
    @IBAction func switchValueChanged(_ sender: Any) {
        retainWebView = retainWebViewSwitch.isOn
    }
    
    @IBAction func loadURLFromFile() {
        removeAndRecreateWebView()
        if let testFile = Bundle.main.url(forResource: "test", withExtension: "html") {
            let request = URLRequest(url: testFile)
            webView?.load(request)
        }
    }
    @IBAction func loadFileURL() {
        removeAndRecreateWebView()
        if let testFile = Bundle.main.url(forResource: "test", withExtension: "html") {
            webView?.loadFileURL(testFile, allowingReadAccessTo: testFile)
        }
    }

    @IBAction func loadString() {
        removeAndRecreateWebView()
        if let testFile = Bundle.main.url(forResource: "test", withExtension: "html") {
            if let htmlString = try? String(contentsOf: testFile) {
                webView?.loadHTMLString(htmlString, baseURL: URL(string: "https://www.salesforce.com")!)
            }
        }
    }

}

