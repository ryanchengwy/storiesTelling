//
//  WebViewController.swift
//  storiesTelling
//
//  Created by Ryan on 28/1/2016.
//  Copyright © 2016 Ryan. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    var webViewUrl : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let webView = WKWebView(frame: UIScreen.mainScreen().bounds)
        self.view.addSubview(webView)
        // Do any additional setup after loading the view.
        if webViewUrl != nil {
            webView.loadRequest(NSURLRequest(URL:NSURL(string: self.webViewUrl!)!))
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
