//
//  SNSBoard.swift
//  wellness
//
//  Created by Kim's_PC on 2016. 6. 8..
//  Copyright © 2016년 kim. All rights reserved.
//

import Foundation
import UIKit
class SNSBoard : UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var SearchTF: UITextField!

    @IBOutlet var BoardTable: UITableView!
var list = Array<SNSContent>()

override func viewDidLoad() {
    super.viewDidLoad()
    //검색바 글 써질수 있게
    
    //리스트에 글 내용 넣기
    let board = SNSContent()
    board.name = "KIM"
    board.date = "2016-06-14"
    self.list.append(board)
    
    self.BoardTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
}


func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.list.count;
}

func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let row = self.list[indexPath.row]
    let cell:UITableViewCell = self.BoardTable.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
    cell.textLabel?.text = row.name
    cell.textLabel?.text = row.date
    
    return cell
}

func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    print("You selected cell #\(indexPath.row)!")
}
}
