//
//  ViewController.swift
//  WebKitHistoryBug
//
//  Created by Arnold Goldberg on 3/9/21.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView?
    @IBOutlet weak var backButton: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.loadURLFromFile()
    //        self.loadFileURL()
            self.loadDataURL()
//            self.loadString()
    }

    @IBAction func goBack(sender: UIButton){
        webView?.evaluateJavaScript("window.history.back();") { _, _ in
            
        }
    }
    
    private func loadURLFromFile() {
        if let testFile = Bundle.main.url(forResource: "test", withExtension: "html") {
            let request = URLRequest(url: testFile)
            webView?.load(request)
        }
    }
    private func loadFileURL() {
        if let testFile = Bundle.main.url(forResource: "test", withExtension: "html") {
            webView?.loadFileURL(testFile, allowingReadAccessTo: testFile)
        }
    }


    private func loadDataURL() {
        if let testFile = Bundle.main.url(forResource: "test", withExtension: "html") {
            if let htmlData = try? Data(contentsOf: testFile) {
                webView?.load(htmlData, mimeType: "text/html", characterEncodingName: "UTF-8", baseURL: URL(string: "https://www.salesforce.com")!)
            }
        }
    }
    
    private func loadString() {
        if let testFile = Bundle.main.url(forResource: "test", withExtension: "html") {
            if let htmlString = try? String(contentsOf: testFile) {
                webView?.loadHTMLString(htmlString, baseURL: testFile)
            }
        }
    }

}

