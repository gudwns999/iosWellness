//
//  FoodRoutine.swift
//  wellness
//
//  Created by Kim's_PC on 2016. 5. 14..
//  Copyright © 2016년 kim. All rights reserved.
//
import Alamofire
import Foundation
import UIKit

class FoodRoutine: UIViewController,UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var addFoodText: UITextField!
    @IBOutlet weak var addKcalText: UITextField!
    @IBOutlet weak var addTimeText: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet var tableView: UITableView!
    var list = Array<FoodContent>()
    var board = FoodContent()
    override func viewWillAppear(animated: Bool) {
        self.tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //검색바 글 써질수 있게
        addFoodText.delegate = self
        addKcalText.delegate = self
        addTimeText.delegate = self
        datePicker.hidden = true
        toolBar.hidden = true
        //리스트에 글 내용 넣기
        let parameters = [
            "food_user_no" : 1,
        ]
        Alamofire.request(.POST,"http://gudwns999.com/PHP/iosGetFood.php",parameters: parameters).responseString{
            response in
            let str:NSString = response.result.value!;
            let sep:[NSString] = str.componentsSeparatedByString("|");
            for var index = 0; index<(sep.count-1); index+=3{
                let name = sep[index]
                let kcal = sep[index+1]
                let date = sep[index+2]
                
                self.board = FoodContent()
                self.board.name = name as String
                self.board.kcal = kcal as String
                self.board.date = date as String
                self.list.append(self.board)
                
                print(name)
                print(kcal)
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
        let cell:FoodCell = self.tableView.dequeueReusableCellWithIdentifier("FoodCell")! as! FoodCell
        cell.foodLabel?.text = row.name
        cell.kcalLabel?.text = row.kcal
        cell.timeLabel?.text = row.date
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("You selected cell #\(indexPath.row)!")
    }
    //먹는시간 클릭하면 datePicker 창 뜸.
    @IBAction func foodEdit(sender: AnyObject) {
        datePicker.backgroundColor = .whiteColor()
      
        toolBar.barStyle = UIBarStyle.Default
        toolBar.translucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        datePicker.hidden = false
        toolBar.hidden = false
        datePicker.addTarget(self, action: #selector(self.datePickerValueChanged), forControlEvents: UIControlEvents.ValueChanged)
    }
    func datePickerValueChanged(sender:UIDatePicker){
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        addTimeText.text = dateFormatter.stringFromDate(sender.date)
    }
    @IBAction func doneAction(sender: AnyObject) {
        datePicker.hidden = true
        toolBar.hidden = true
    }
    //이 내용 서버에 전달
    @IBAction func sendServer(sender: AnyObject) {
//        let nuo =
        let kca = addKcalText.text
        let nam = addFoodText.text
        let dat = addTimeText.text
        writeServer(1, KCA: kca!, NAM: nam!, DAT: dat!)
        //table 갱신
        self.board = FoodContent()
        self.board.name = nam
        self.board.kcal = kca
        self.board.date = dat
        self.list.append(self.board)

        self.tableView.reloadData()
    }
    //서버에 정보 보냄
    func writeServer(UID:Int,KCA:String,NAM:String, DAT:String){
        let parameters = [
            "food_user_no" : UID,
            "food_kcal" : KCA,
            "food_name" : NAM,
            "food_date" : DAT,
        ]
        Alamofire.request(.POST, "http://gudwns999.com/PHP/iosWriteFood.php", parameters: parameters as? [String : AnyObject])
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

}