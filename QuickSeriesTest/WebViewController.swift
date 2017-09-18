//
//  WebViewController.swift
//  QuickSeriesTest
//
//  Created by CtanLI on 2017-09-17.
//  Copyright © 2017 QuickSeries. All rights reserved.
//

import UIKit

class WebViewController: UIViewController, UIWebViewDelegate, UIScrollViewDelegate, Reusable {
    
    var webLink = ""
    
    //outlets
    @IBOutlet weak var webView: UIWebView!
    
    
    //
    //MARK:- Override
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        guard webLink.isEmpty != true else {
            return
        }
        webView.loadRequest(URLRequest(url: URL(string: webLink)!))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //
    //MARK:- UIWebView delegate
    //
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        webView.scrollView.delegate = self // set delegate method of UISrollView
        webView.scrollView.maximumZoomScale = 10
        webView.scrollView.minimumZoomScale = 1
    }
}
