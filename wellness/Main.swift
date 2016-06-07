//
//  ViewController.swift
//  wellness
//
//  Created by Kim's_PC on 2016. 4. 29..
//  Copyright © 2016년 kim. All rights reserved.
//

import UIKit

class Main: UIViewController{
 
    @IBOutlet var snsBTN: UIButton!
    @IBOutlet var wellBTN: UIButton!
    @IBOutlet var myWebView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 화면이 불려지면 웹뷰가 시작
        let url = NSURL (string: "http://www.gudwns999.com");
        let requestObj = NSURLRequest(URL: url!);
        self.myWebView.loadRequest(requestObj);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //SNS버튼 눌러을 시 이벤트
    @IBAction func sendSNSBTN(sender: UIButton) {

    }
    //웰니스 버튼 눌렀을 시 이벤트
    @IBAction func sendWellBTN(sender: UIButton) {
    }
    
}