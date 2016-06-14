//
//  HealthRoutine.swift
//  wellness
//
//  Created by Kim's_PC on 2016. 5. 14..
//  Copyright © 2016년 kim. All rights reserved.
//
import Alamofire
import Foundation
import UIKit

class HealthRoutine: UIViewController,UITableViewDelegate, UITableViewDataSource, UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate {

    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var addExeText: UITextField!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet var tableView: UITableView!
    var list = Array<HealthContent>()
    @IBOutlet weak var addDateText: UITextField!
    @IBOutlet weak var addSetText: UITextField!
    @IBOutlet weak var addWeightText: UITextField!
    @IBOutlet weak var addAmountText: UITextField!
    var board = HealthContent()
    var pickerDataSource = ["월","화","수","목","금","토","일"];
    override func viewWillAppear(animated: Bool) {
        self.tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickerView.dataSource = self
        self.pickerView.delegate = self
        addExeText.delegate = self
        addDateText.delegate = self
        addSetText.delegate = self
        addWeightText.delegate = self
        addAmountText.delegate = self
        
        pickerView.hidden = true
        toolBar.hidden = true
               let parameters = [
            "health_user_no" : 1,
            ]
        Alamofire.request(.POST,"http://gudwns999.com/PHP/iosGetHealth.php",parameters: parameters).responseString{
            response in
            let str:NSString = response.result.value!;
            let sep:[NSString] = str.componentsSeparatedByString("|");
            for var index = 0; index<(sep.count-1); index+=5{
                let name = sep[index]
                let set = sep[index+1]
                let amount = sep[index+2]
                let weight = sep[index+3]
                let date = sep[index+4]
                
                self.board = HealthContent()
                self.board.name = name as String
                self.board.set = set as String
                self.board.amount = amount as String
                self.board.weight = weight as String
                self.board.date = date as String
                self.list.append(self.board)
                
                print(name)
                print(set)
                print(amount)
                print(weight)
                print(date)
                
                self.tableView.reloadData()
            }
            
        }
    }

    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count;
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let row = self.list[indexPath.row]
        let cell:HealthCell = self.tableView.dequeueReusableCellWithIdentifier("HealthCell")! as! HealthCell
        cell.nameText?.text = row.name
        cell.setText?.text = row.set
        cell.amountText?.text = row.amount
        cell.weightText?.text = row.weight
        cell.dateText?.text = row.date
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("You selected cell #\(indexPath.row)!")
    }
    //picker관련
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        addDateText.text = pickerDataSource[row]
        return pickerDataSource[row]
    }
    //서버에 정보 보냄
    func writeServer(UID:Int,EXE:String, SET:String, AMT:String, WEI:String, DAT:String){
        let parameters = [
            "health_user_no" : UID,
            "health_name" : EXE,
            "health_set" : SET,
            "health_amount" : AMT,
            "health_weight" : WEI,
            "health_date" : DAT

        ]
        Alamofire.request(.POST, "http://gudwns999.com/PHP/iosWriteHealth.php", parameters: parameters as! [String : AnyObject])
            .responseString { response in
                print(response.result)
                if let JSON = response.result.value{
                    print(JSON)
                    //창띄움
                    //create an alert controller
                    let pending = UIAlertController(title: "조금만 기다려주세요", message: "서버에 저장 중", preferredStyle: .Alert)
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
                    })
                    
                }
        }
    }

    @IBAction func selectPicker(sender: AnyObject) {
        pickerView.hidden = false
        toolBar.hidden = false
        //pickerView설정내용
        pickerView.backgroundColor = .whiteColor()
        pickerView.showsSelectionIndicator = true
        toolBar.barStyle = UIBarStyle.Default
        toolBar.translucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()

        doneButton = UIBarButtonItem(title: "확인", style: UIBarButtonItemStyle.Bordered, target: self, action: "donePicker")
        toolBar.userInteractionEnabled = true
    }
    @IBAction func donePick(sender: AnyObject) {
 //       pickerView.removeFromSuperview()
 //       toolBar.removeFromSuperview()
        pickerView.hidden = true
        toolBar.hidden = true
    }
    //글내용을 서버에 보낸다.
    @IBAction func sendServer(sender: AnyObject) {
//        let uno = core data에서 user_no를 가져와야함.. 앞으로의 과제
        let exe = addExeText.text
        let set = addSetText.text
        let amt = addAmountText.text
        let wei = addWeightText.text
        let dat = addDateText.text
        
        writeServer(1, EXE: exe!, SET: set!, AMT: amt!, WEI: wei!, DAT: dat!)
        //임시로 넣어줌
        self.board = HealthContent()
        self.board.name = exe
        self.board.set = set
        self.board.amount = amt
        self.board.weight = wei
        self.board.date = dat
        self.list.append(self.board)

        self.tableView.reloadData()

    }
    
}
