//
//  Login.swift
//  wellness
//
//  Created by Kim's_PC on 2016. 5. 13..
//  Copyright © 2016년 kim. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

class Login : UIViewController,UITextFieldDelegate{
    @IBOutlet var LoginIDTF: UITextField! //ID 값 받아오기
    @IBOutlet var LoginPWTF: UITextField! //PW 값 받아오기
    @IBOutlet var LoginBTN: UIButton!   //로킨 버튼
    @IBOutlet var RegistBTN: UIButton!  //등록 버튼
    @IBOutlet var TestLabel: UILabel!

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
    super.viewDidLoad()
        LoginIDTF.delegate = self
        LoginPWTF.delegate = self
    }
    //로그인 버튼 눌렀을 시
    @IBAction func SendLoginBTN(sender: UIButton) {
        let id = LoginIDTF.text
        let pw = LoginPWTF.text
        checkID(id!, UPW: pw!)
        
    }
    //회원가입 버튼 눌렀을 시
    @IBAction func SendRegistBTN(sender: UIButton) {

    }
    
    //checkID시 HTTP Post를 사용하기 때문에 딜레이가 필요하다.
    func checkID(UID:String, UPW:String){
        let parameters = [
            "user_id" : UID,
            "user_pw" : UPW
        ]
        Alamofire.request(.POST, "http://gudwns999.com/PHP/iosCheckID.php", parameters: parameters)
            .responseString { response in
                print(response.result)
                if let JSON = response.result.value{
                    print(JSON)
                    //창띄움
                    //create an alert controller
                    let pending = UIAlertController(title: "조금만 기다려주세요", message: "서버 확인 중", preferredStyle: .Alert)
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
                        
                        if(JSON == "User Found"){
                            //유저 찾으면 다음 화면으로 이동.
                            indicator.stopAnimating();
                            self.dismissViewControllerAnimated(false, completion: nil)
                            
                            self.TestLabel.text = "확인"
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let nextViewController = storyboard.instantiateViewControllerWithIdentifier("MMain") as! Main
                            self.presentViewController(nextViewController, animated: true, completion: nil)
                        }
                        else{
                            //유저 못찾으면 에러 표시.
                            indicator.stopAnimating();
                            self.dismissViewControllerAnimated(false, completion: nil)
                            
                            self.TestLabel.text = "실패"
                            
                        }
                    })
                   
                }
        }

    }
}


