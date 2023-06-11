//
//  DetailViewController.swift
//  mySampleSkills
//
//  Created by Ivan Santos on 11/06/23.
//

import Foundation
import UIKit
import WebKit

class DetailViewController: UIViewController {
    var urlGit: String?

    @IBOutlet weak var webview: WKWebView!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var viewProgress: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoading()
        webview.allowsBackForwardNavigationGestures = true
        if let url = URL(string: urlGit ?? "") {
            webview.load(URLRequest(url: url))
            webview.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil);

        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            let progress: Float = Float(self.webview.estimatedProgress)
            self.progressView.progress = Float(progress)
            if progress >= 1 {
                hideLoading()
            }
        }
    }
    
    private func showLoading() {
        progressView.progress = 0
        viewProgress.alpha = 1
    }
    
    private func hideLoading() {
        viewProgress.alpha = 0
    }
}
