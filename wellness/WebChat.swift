//
//  WebChat.swift
//  wellness
//
//  Created by Kim's_PC on 2016. 6. 11..
//  Copyright © 2016년 kim. All rights reserved.
//

import Foundation
import UIKit

class WebChat: UIViewController, UIWebViewDelegate{
    @IBOutlet weak var myWebView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        myWebView.delegate = self
        let url = NSURL (string: "http://www.gudwns999.com:3000");
        let requestObj = NSURLRequest(URL: url!);
        self.myWebView.loadRequest(requestObj)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startChat(sender: AnyObject) {
        self.myWebView.hidden = false
    }
    @IBAction func endChat(sender: AnyObject) {
        self.myWebView.hidden = true
    }
}