//
//  DreamMsgDetailViewController.swift
//  DreamWeibo
//
//  Created by 孙龙霄 on 4/6/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

import UIKit

class DreamMsgDetailViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate {

    
    var index = 0
    var user:DreamUser?
    var messages:NSArray?{
        didSet{
            
            self.messages = messages?.sortedArrayUsingComparator({ (messageA, messageB) -> NSComparisonResult in
                
                let a = messageA as! DreamMessage
                let b = messageB as! DreamMessage
                
                let result =  TimeTool.ifOneAboveTwo(a.created_at, anotherTime: b.created_at)
                return result
            
            })
            
            messagesFrame = NSMutableArray()
            var num = 0;
            for message in messages! {
                let msg = message as! DreamMessage
                var frame = MessageDetailViewFrame()
                
                var showTime = true
                if num - 1 > 0 {
                    let nextMessage = messages![num - 1] as! DreamMessage
                    showTime = TimeTool.showTime(message.created_at, anotherTime: nextMessage.created_at)
                }
                frame.showTime = showTime
                frame.message = msg
                messagesFrame?.addObject(frame)
                num++;
            }
        }
    }
    var messagesFrame:NSMutableArray?
    var tableView:UITableView!
    var toolbar:DreamMsgToolbar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        setupNavigateItems()
        
        setupTableView()
        
        
        setupToolbar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func setupNavigateItems(){
        
        switch(index){
        case 0:
            self.title = "@我的"
            break;
        case 1:
            self.title = "评论"
            break;
        case 2:
            self.title = "赞"
            break;
        default:
            self.title = user!.name
            break;
        }
    }
    
    func setupTableView(){
        
        tableView = UITableView()
        
        tableView.width = self.view.width
        tableView.height = self.view.height - 40
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(tableView)
        
    }
    
    func setupToolbar(){
        
        toolbar = DreamMsgToolbar()
        self.view.addSubview(toolbar)

        toolbar.x = 0
        toolbar.y = CGRectGetMaxY(tableView.frame)
        toolbar.height = 40
        toolbar.width = self.view.width

        
        toolbar.image = UIImage.resizeImage("message_toolbar_background")
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyBoardWillShow:", name: "UIKeyboardWillShowNotification", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: "UIKeyboardWillHideNotification", object: nil)
    }
    
    
    func keyBoardWillShow(note:NSNotification){
        
        
        let dic = note.userInfo!
        
        let duration = dic[UIKeyboardAnimationDurationUserInfoKey] as! Double
        
        UIView.animateWithDuration(duration, animations: { () -> Void in
            
            let keyboardF = (dic[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
            let keyboardH = keyboardF.size.height
            
            self.toolbar?.transform = CGAffineTransformMakeTranslation(0, -keyboardH)
            
            
        })
        
    }
    
    func keyboardWillHide(note:NSNotification){
        
        let dic = note.userInfo!
        
        let duration = dic[UIKeyboardAnimationDurationUserInfoKey] as! Double
        UIView.animateWithDuration(duration, animations: { () -> Void in
            self.toolbar!.transform = CGAffineTransformIdentity;
            
        })
    }
    

    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (messages == nil ? 0 : messages!.count)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let ID = "msgCell"
        var cell = tableView.dequeueReusableCellWithIdentifier(ID) as? MessageDetailCell
        if cell == nil {
            let message = messages![indexPath.row] as! DreamMessage
            let messageFrame = messagesFrame![indexPath.row] as! MessageDetailViewFrame
            
            cell = MessageDetailCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: ID,messageFrame: messageFrame,senderImageFilePath: self.user!.avatar_large)
        }
        
        return cell!
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if  messagesFrame != nil {
            return (messagesFrame![indexPath.row] as! MessageDetailViewFrame).frame.height
        }
        return 0
    }

}
