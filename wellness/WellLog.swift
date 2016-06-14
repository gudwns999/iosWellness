//
//  WellLog.swift
//  wellness
//
//  Created by Kim's_PC on 2016. 5. 14..
//  Copyright © 2016년 kim. All rights reserved.
//
import Alamofire
import Foundation
import UIKit

class WellLog: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    var list = Array<LogContent>()
    var board = LogContent()
    override func viewWillAppear(animated: Bool) {
        self.tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //검색바 글 써질수 있게
        
        //리스트에 글 내용 넣기
        board.name = "닭고기"
        board.date = "2016-06-14"
        self.list.append(board)
        
        //리스트에 글 내용 넣기
        let parameters = [
            "log_user_no" : "1",
            ]
        Alamofire.request(.POST,"http://gudwns999.com/PHP/iosGetLog.php",parameters: parameters).responseString{
            response in
            let str:NSString = response.result.value!;
            let sep:[NSString] = str.componentsSeparatedByString("|");
            for var index = 0; index<(sep.count-1); index+=2{
                let name = sep[index]
                let date = sep[index+1]

                
                self.board = LogContent()
                self.board.name = name as String
                self.board.date = date as String
                 self.list.append(self.board)
                
                print(name)
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
        let cell:LogCell = self.tableView.dequeueReusableCellWithIdentifier("LogCell")! as! LogCell
        cell.nameLabel?.text = row.name
        cell.dateLabel?.text = row.date
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("You selected cell #\(indexPath.row)!")
    }
    
}
