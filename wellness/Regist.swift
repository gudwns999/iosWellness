//
//  Regist.swift
//  wellness
//
//  Created by Kim's_PC on 2016. 5. 14..
//  Copyright © 2016년 kim. All rights reserved.
//
import Foundation
import Alamofire
import UIKit
class Regist : UIViewController, UITextFieldDelegate{
    @IBOutlet var RegistIDTF: UITextField!
    @IBOutlet var RegistPWTF: UITextField!
    @IBOutlet var RegistCFTF: UITextField!//중복 확인
    @IBOutlet var RegistSexSC: UISegmentedControl!
    @IBOutlet var RegistAgreeSW: UISwitch!
    @IBOutlet var RegistSubmitBTN: UIButton!
    @IBOutlet weak var RegistCheckUL: UILabel!
    //Flag
    var confirmFlag = 0
    //성별(고정값 남)
    var sex = "남"
    override func viewDidLoad() {
        super.viewDidLoad()
        RegistIDTF.delegate = self
        RegistPWTF.delegate = self
        RegistCFTF.delegate = self
    }
    //중복확인 버튼 눌렀을시 이벤트
    @IBAction func sendConfirmBTN(sender: UIButton) {
        let id = RegistIDTF.text
        confirmID(id!)
    }
    
    //회원가입 신청 버튼 눌렀을시 이벤트
    @IBAction func sendSubmitBTN(sender: UIButton) {
        let id = RegistIDTF.text
        let pw = RegistPWTF.text
        let cfpw = RegistCFTF.text
        if(cfpw == pw && confirmFlag==1){
            registID(id!,RPW:pw!,RSEX: sex)
        }
        else if(cfpw != pw){
            //비밀번호 확인 경고창
        }
        else if(confirmFlag==0){
            //중복확인 경고창
        }
    }
    
    //중복확인 함수
    func confirmID(RID:String){
        let parameters = [
            "user_id" : RID
        ]
        Alamofire.request(.POST, "http://gudwns999.com/PHP/iosConfirmID.php", parameters: parameters)
            .responseString { response in
                if let JSON = response.result.value{
                    print(JSON)
                    //창띄움
                    //create an alert controller
                    let pending = UIAlertController(title: "조금만 기다려주세요", message: "아이디 확인 중", preferredStyle: .Alert)
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
                        
                    if(JSON == "User Found"){
                        indicator.stopAnimating();
                        self.dismissViewControllerAnimated(false, completion: nil)
                        self.RegistCheckUL.text = "이미 있는 아이디"
                    }
                    else if(JSON=="No Such User Found"){
                        indicator.stopAnimating();
                        self.dismissViewControllerAnimated(false, completion: nil)
                        self.RegistCheckUL.text = "사용 가능 아이디"
                        self.confirmFlag = 1
                    }
                })
            }
        }
    }
    //성별 선택
    @IBAction func selectSEX(sender: UISegmentedControl) {
        switch RegistSexSC.selectedSegmentIndex {
        case 0:
            sex = "남"
        case 1:
            sex = "여"
        default:
            sex = "남"
            break;
        }
    }
    //등록 함수
    func registID(RID:String, RPW:String, RSEX:String){
        let parameters = [
            "user_id" : RID,
            "user_pw" : RPW,
            "user_sex": RSEX
        ]
        Alamofire.request(.POST, "http://gudwns999.com/PHP/iosRegistID.php", parameters: parameters)
            .responseString { response in
                if let JSON = response.result.value{
                    print(JSON)
                    //창띄움
                    //create an alert controller
                    let pending = UIAlertController(title: "조금만 기다려주세요", message: "서버 등록 중", preferredStyle: .Alert)
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
                        
                        //등록이 완료 되면 이 문장이 나옴
                        if(JSON == "SUCCESS REGIST"){
                            indicator.stopAnimating();
                            self.dismissViewControllerAnimated(false, completion: nil)
                            //메인 화면으로 넘어가면 됨.
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let nextViewController = storyboard.instantiateViewControllerWithIdentifier("MMain") as! Main
                            self.presentViewController(nextViewController, animated: true, completion: nil)
                        }
                        else{
                            indicator.stopAnimating();
                            self.dismissViewControllerAnimated(false, completion: nil)
                        }
                    })
                   
                }
        }
    }
}

