//
//  ViewController.swift
//  wellness
//
//  Created by Kim's_PC on 2016. 4. 29..
//  Copyright © 2016년 kim. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
 

    @IBOutlet var myWebView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let url = NSURL (string: "http://www.gudwns999.com");
        let requestObj = NSURLRequest(URL: url!);
        self.myWebView.loadRequest(requestObj);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}