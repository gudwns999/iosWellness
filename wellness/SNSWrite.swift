//
//  SNSWrite.swift
//  wellness
//
//  Created by Kim's_PC on 2016. 6. 9..
//  Copyright © 2016년 kim. All rights reserved.
//
import Alamofire
import Foundation
import UIKit

class SNSWrite:UIViewController, UITextFieldDelegate{
    
    @IBOutlet var WriteTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        WriteTF.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //Write버튼이 눌리면 발생하는 이벤트
    @IBAction func SendServerTF(sender: AnyObject) {
        let userID = "형준맨"
        let content = WriteTF.text
        let routin = "0"
        let image = "0"
        sendContent(userID, UCO:content!,URU:routin,UIM:image)
    }
    
    //sendContent함수 정의
    func sendContent(UID:String,UCO:String,URU:String,UIM:String){
        let parameters = [
            "board_writer" : UID,
            "board_content" : UCO,
            "board_routine" : URU,
            "board_image" : UIM
        ]
        Alamofire.request(.POST, "http://gudwns999.com/PHP/iosUploadBoard.php", parameters: parameters)
            .responseString { response in
                print(response.result)
                if let JSON = response.result.value{
                    print(JSON)
                    //창띄움
                    //create an alert controller
                    let pending = UIAlertController(title: "조금만 기다려주세요", message: "글 입력 중", preferredStyle: .Alert)
                    //create an activity indicator
                    let indicator = UIActivityIndicatorView(frame: pending.view.bounds)
                    indicator.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
                    //add the activity indicator as a subview of the alert controller's view
                    pending.view.addSubview(indicator)
                    indicator.userInteractionEnabled = false // required otherwise if there buttons in the UIAlertController you will not be able to press them
                    indicator.startAnimating()
                    self.presentViewController(pending, animated: true, completion: nil)
                    
                    //싱크를 위해 살짝 딜레이를 줌.
                    let seconds = 1.5
                    let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
                    let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
                    
                    dispatch_after(dispatchTime, dispatch_get_main_queue(), {
                        
                        // here code perfomed with delay
                            //처음 화면으로 이동.
                            indicator.stopAnimating();
                            self.dismissViewControllerAnimated(false, completion: nil)
                            let storyboard = UIStoryboard(name: "SNS", bundle: nil)
                            let nextViewController = storyboard.instantiateViewControllerWithIdentifier("MSNS") as! SNS
                            self.presentViewController(nextViewController, animated: true, completion: nil)
                    })
                    
                }
        }
        
    }


}