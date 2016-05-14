//
//  Login.swift
//  wellness
//
//  Created by Kim's_PC on 2016. 5. 13..
//  Copyright © 2016년 kim. All rights reserved.
//

import Foundation
import UIKit

class Login : UIViewController,UITextFieldDelegate{
    @IBOutlet var LoginIDTF: UITextField! //ID 값 받아오기
    @IBOutlet var LoginPWTF: UITextField! //PW 값 받아오기
    @IBOutlet var LoginBTN: UIButton!
    
    @IBOutlet var TestLabel: UILabel!

    override func viewDidLoad() {
    super.viewDidLoad()
        LoginIDTF.delegate = self
    }
    @IBAction func SendLoginBTN(sender: UIButton) {
        //       let id = LoginIDTF.text
        //       let pw = LoginPWTF.text
        TestLabel.text = LoginIDTF.text
        
    }
}
func snedCheckID()
{
//POST REQUEST in SWIFT
let urlPath: String = "http://gudwns999.com/PHP/checkID.php"
let url: NSURL = NSURL(string: urlPath)!
let request1: NSMutableURLRequest = NSMutableURLRequest(URL: url)

request1.HTTPMethod = "POST"
let stringPost="ID=kim&PW=123" // Key and Value

let data = stringPost.dataUsingEncoding(NSUTF8StringEncoding)

request1.timeoutInterval = 60
request1.HTTPBody=data
request1.HTTPShouldHandleCookies=false

let queue:NSOperationQueue = NSOperationQueue()

NSURLConnection.sendAsynchronousRequest(request1, queue: queue, completionHandler:{ (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
    
    do {
        if let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary {
            print("ASynchronous\(jsonResult)")
        }
    } catch let error as NSError {
        print(error.localizedDescription)
    }
})
}