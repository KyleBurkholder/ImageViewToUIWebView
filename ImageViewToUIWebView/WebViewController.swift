//
//  WebViewController.swift
//  ImageViewToUIWebView
//
//  Created by Kyle Burkholder on 7/8/18.
//  Copyright © 2018 Kyle Burkholder. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController
{
    
    var urlToLoad: URL? = nil
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.uiDelegate = self
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        if let url = urlToLoad
        {
            webView.load(URLRequest(url: url))
        }
    }
    // MARK: - Navigation

    @IBAction func goBack(_ sender: UIButton)
    {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension WebViewController: WKUIDelegate
{
    
}
