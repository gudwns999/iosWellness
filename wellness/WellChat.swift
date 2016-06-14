//
//  WellChat.swift
//  wellness
//
//  Created by Kim's_PC on 2016. 5. 14..
//  Copyright © 2016년 kim. All rights reserved.
//

import Foundation
import UIKit

class WellChat: UIViewController,UITableViewDelegate, UITableViewDataSource, UITextViewDelegate, UIGestureRecognizerDelegate, UITextFieldDelegate{
    //사용자 입력 받음.
    @IBOutlet weak var userInput: UITextField!
    //채팅 내용 보여질 곳
    @IBOutlet var chatView: UITableView!
    //누군가 글 쓰고 있으면 보여짐.
    @IBOutlet var someWrite: UILabel!
    
    //보여질 채팅 내용은 닉네임:메세지:보낸시간이 될 것이다.
    var nickname: String!
    var chatMessages = [[String: AnyObject]]()
    override func viewDidLoad() {
        //누군가가 타이핑 하면 발생.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.handleUserTypingNotification(_:)), name: "userTypingNotification", object: nil)
        //타이핑 하다 멈춤.
        let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        swipeGestureRecognizer.direction = UISwipeGestureRecognizerDirection.Down
        swipeGestureRecognizer.delegate = self
        view.addGestureRecognizer(swipeGestureRecognizer)


    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        configureTableView()
//     configureNewsBannerLabel()
        configureOtherUserActivityLabel()
        userInput.delegate = self
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        SocketIOManager.sharedInstance.getChatMessage { (messageInfo) -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.chatMessages.append(messageInfo)
                self.chatView.reloadData()
//                self.scrollToBottom()
            })
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    //버튼 누르면 서버로 메세지 전송.
    @IBAction func sendMessage(sender: AnyObject) {
        if userInput.text!.characters.count > 0 {
            nickname = "형준맨"
            SocketIOManager.sharedInstance.sendMessage(userInput.text!, withNickname: nickname)
            userInput.text = ""
            userInput.resignFirstResponder()
        }
    }
        func configureTableView() {
            chatView.delegate = self
            chatView.dataSource = self
            chatView.registerNib(UINib(nibName: "ChatCell", bundle: nil), forCellReuseIdentifier: "idCellChat")
            chatView.estimatedRowHeight = 90.0
            chatView.rowHeight = UITableViewAutomaticDimension
            chatView.tableFooterView = UIView(frame: CGRectZero)
        }
        
        func configureOtherUserActivityLabel() {
            someWrite.hidden = true
            someWrite.text = ""
        }
    //타이핑 시작할 때 발생하는 함수
    // MARK: UITextViewDelegate Methods
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        nickname = "형준맨"
        //후에 core Data에서 가져오는 걸로.
        SocketIOManager.sharedInstance.sendStartTypingMessage(nickname)
        
        return true
    }
    // MARK: UIGestureRecognizerDelegate Methods
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    //누구가 타이핑 치고 있으면 발생하는 이벤트
    func handleUserTypingNotification(notification: NSNotification) {
        if let typingUsersDictionary = notification.object as? [String: AnyObject] {
            var names = ""
            var totalTypingUsers = 0
            for (typingUser, _) in typingUsersDictionary {
                if typingUser != nickname {
                    names = (names == "") ? typingUser : "\(names), \(typingUser)"
                    totalTypingUsers += 1
                }
            }
            
            if totalTypingUsers > 0 {
                let verb = (totalTypingUsers == 1) ? "is" : "are"
                
                someWrite.text = "\(names) \(verb) now typing a message..."
                someWrite.hidden = false
            }
            else {
                someWrite.hidden = true
            }
        }
        
    }
    //키보드 한번 더 누름.
    func dismissKeyboard() {
        if userInput.isFirstResponder() {
            userInput.resignFirstResponder()
            
            SocketIOManager.sharedInstance.sendStopTypingMessage(nickname)
        }
    }
    
    // MARK: UITableView Delegate and Datasource Methods
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatMessages.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("idCellChat", forIndexPath: indexPath) as! ChatCell
        
        let currentChatMessage = chatMessages[indexPath.row]
        let senderNickname = currentChatMessage["nickname"] as! String
        let message = currentChatMessage["message"] as! String
        let messageDate = currentChatMessage["date"] as! String
        
        if senderNickname == nickname {
            cell.lblChatMessage.textAlignment = NSTextAlignment.Right
            cell.lblMessageDetails.textAlignment = NSTextAlignment.Right
            
//            cell.lblChatMessage.textColor = lblNewsBanner.backgroundColor
        }
        
        cell.lblChatMessage.text = message
        cell.lblMessageDetails.text = "by \(senderNickname.uppercaseString) @ \(messageDate)"
        
        cell.lblChatMessage.textColor = UIColor.darkGrayColor()
        
        return cell
    }
    
    
    // MARK: UITextViewDelegate Methods
    
    func someWrite(textView: UITextView) -> Bool {
        nickname = "ss"
        SocketIOManager.sharedInstance.sendStartTypingMessage(nickname)
        
        return true
    }


}