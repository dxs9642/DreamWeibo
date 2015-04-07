//
//  MessageViewController.swift
//  DreamWeibo
//
//  Created by 孙龙霄 on 1/15/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

import UIKit

class MessageViewController: UITableViewController {
    
    var initial = true
    var msg = NSMutableDictionary()
    var userInfo = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发起聊天", style: UIBarButtonItemStyle.Done, target: nil, action: nil)
        

        self.tableView.backgroundColor = UIColor(red: 211/255, green: 211/255, blue: 211/255, alpha: 1.0)
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        getUnreadMessage()
        
    }



    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3 + msg.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let ID = "message"
        var cell = tableView.dequeueReusableCellWithIdentifier(ID) as MessageSimpleCell?
        
        if cell == nil{
            cell = MessageSimpleCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: ID,type: indexPath.row)
        }
        
        let num = indexPath.row
        if num >= 3 {
            let user = self.userInfo[num - 3] as DreamUser
            cell?.setupUserAndMessage(user, msg: self.msg[user.idstr] as NSArray)
        }
        
        return cell!
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var newView = DreamMsgDetailViewController()
        let num = indexPath.row
        newView.index = num
        if num >= 3 {
            newView.user = self.userInfo[num - 3] as? DreamUser
            newView.messages = self.msg[newView.user!.idstr] as? NSArray
        }
        
        self.navigationController?.pushViewController(newView, animated: true)
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70
    }
    
    
    func getUnreadMessage(){
        
        
        var params = NSMutableDictionary()
        if initial {
            DreamHttpTool.post("http://weidreambo.sinaapp.com/getInfo.php", params: params, success: { (obj:AnyObject!) -> Void in
            
                let result = obj as NSArray
                let messages = DreamMessage.objectArrayWithKeyValuesArray(result)
                self.dealWithMessages(messages)
                self.getUserData()
            }) { () -> Void in
                
            }
        }else{
            
            
            
        }
        
        
    }

    
    func dealWithMessages(messages:NSArray){
        
        let group = NSMutableDictionary()
        
        for message in messages {
            
            let msg = message as DreamMessage
            let id = message.sender_id
            if group[id] == nil {
                var arr = NSMutableArray()
                arr.addObject(message)
                group[id] = arr
            }else{
                var arr = group[id] as NSMutableArray
                arr.addObject(message)
                group[id] = arr
            }
            
        }
        
        self.msg = group
        
        
    }
    
    func getUserData(){
        
        let account = Account.getAccount()
        if account == nil {
            Account.expiredAndReAuth()
        }
        
        for (key,value) in msg {
            
            let userId = key as NSString
            
            var params = NSMutableDictionary()
            params["access_token"] = account!.access_token
            params["uid"] = userId
            
            DreamHttpTool.get("https://api.weibo.com/2/users/show.json", params: params, success: { (obj:AnyObject!) -> Void in
                
                let result = obj as NSDictionary
                let user = DreamUser(keyValues: result)
                self.userInfo.addObject(user)
                self.finish()
                
                }) { () -> Void in
                    
            }

            
            
        }
        
    }
    
    func finish(){
        if self.userInfo.count == msg.count {
            self.tableView.reloadData()
        }
    }

}
