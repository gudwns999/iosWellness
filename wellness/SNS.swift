//
//  SNSViewController.swift
//  wellness
//
//  Created by Kim's_PC on 2016. 5. 1..
//  Copyright © 2016년 kim. All rights reserved.
//
import Alamofire
import Foundation
import UIKit


class SNS: UIViewController,UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate {
    
    //게시글 내용
    
    @IBOutlet var tableView: UITableView!
    

    
    //검색바
    @IBOutlet weak var SearchTF: UITextField!

    var list = Array<SNSContent>()
    var board = SNSContent()
    override func viewWillAppear(animated: Bool) {
            self.tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //검색바 글 써질수 있게
        
        //리스트에 글 내용 넣기
        Alamofire.request(.POST,"http://gudwns999.com/PHP/iosGetBoard.php",parameters: nil, encoding: .JSON).responseString{
            response in
            let str:NSString = response.result.value!;
            let sep:[NSString] = str.componentsSeparatedByString("|");
            for var index = 0; index<(sep.count-1); index+=5{
                let id = sep[index]
                let content = sep[index+1]
                let date = sep[index+2]
                let like = sep[index+3]
                let reply = sep[index+4]

                self.board = SNSContent()
                self.board.name = id as String
                self.board.content = content as String
                self.board.date = date as String
                self.board.like = like as String
                self.board.reply = reply as String
                
                self.list.append(self.board)
                
                print(id)
                print(content)
                print(date)
                print(like)
                print(reply)
                
                self.tableView.reloadData()

            }
      
        }
    }
    //cell 갯수 알려줌
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count;
    }
    //게시글 대입
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let row = self.list[indexPath.row]
        let cell:SNSCell = self.tableView.dequeueReusableCellWithIdentifier("SNSCell")! as! SNSCell
        cell.IDLabel?.text = row.name
        cell.dateLabel?.text = row.date
        cell.contentLabel?.text = row.content
        cell.likeLabel?.text = row.like
        cell.replyLabel?.text = row.reply
        
        return cell
    }
    //게시글 눌러졌을때 이벤트
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("You selected cell #\(indexPath.row)!")
    }
}
