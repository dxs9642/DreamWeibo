//
//  DreamMsgDetailViewController.swift
//  DreamWeibo
//
//  Created by 孙龙霄 on 4/6/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

import UIKit

class DreamMsgDetailViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate,MsgToolbarButtonClickProtocol {

    
    var index = 0
    var user:DreamUser?
    var keyboardH:CGFloat = 0
    var firstLoadding = true
    var reloading = false
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
                if num > 0 {
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
    var isChangingKeyboard = false
    var keyboard = DreamEmotionKeyboard()
    var progressView:UCZProgressView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        setupNavigateItems()
        
        setupTableView()
        
        
        setupToolbar()
        
        setupProgressView()
        keyboard.height = 216
        keyboard.width = UIScreen.mainScreen().bounds.width
        
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
        toolbar.delegate = self
        self.view.addSubview(toolbar)

        toolbar.x = 0
        toolbar.y = CGRectGetMaxY(tableView.frame)
        toolbar.height = 40
        toolbar.width = self.view.width

        
        toolbar.image = UIImage.resizeImage("message_toolbar_background")
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyBoardWillShow:", name: "UIKeyboardWillShowNotification", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: "UIKeyboardWillHideNotification", object: nil)
    }
    
    func setupProgressView(){
        
        progressView = UCZProgressView()
        progressView.setTranslatesAutoresizingMaskIntoConstraints(false)
        progressView.frame = self.view.frame
        progressView.indeterminate = true
        progressView.blurEffect = UIBlurEffect(style: UIBlurEffectStyle.ExtraLight)
        progressView.hidden = true
        self.view.addSubview(progressView)
        
        let anim = CATransition()
        anim.duration = 1
        anim.type = "reveal"
        progressView.layer.addAnimation(anim, forKey: nil)
        progressView.hidden = false
        
        if firstLoadding{
            finishLoading(0.7)
            firstLoadding = false
        }
    }
    
    func finishLoading(time:Float){
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64( time * Float(NSEC_PER_SEC) )) , dispatch_get_main_queue()) { () -> Void in
            
            self.progressView.setProgress(1.1, animated: true)
            
        }

        
    }
    
    func keyBoardWillShow(note:NSNotification){
        
        
        let dic = note.userInfo!
        
        let duration = dic[UIKeyboardAnimationDurationUserInfoKey] as! Double
        
        UIView.animateWithDuration(duration, animations: { () -> Void in
            
            let keyboardF = (dic[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
            let keyboardH = keyboardF.size.height
            
            self.toolbar?.transform = CGAffineTransformMakeTranslation(0, -keyboardH)
            
            
            
            self.tableView.height = self.tableView.height - (keyboardH - self.keyboardH)

            self.keyboardH = keyboardH
        
        })

        if self.messages == nil {
            return
        }
        
        let lastRow = NSIndexPath(forRow: self.messages!.count - 1 , inSection: 0)
        self.tableView.scrollToRowAtIndexPath(lastRow, atScrollPosition: UITableViewScrollPosition.Top, animated: true)
        

    }
    
    func keyboardWillHide(note:NSNotification){
        if isChangingKeyboard {
            return
        }
        
        let dic = note.userInfo!
        
        let duration = dic[UIKeyboardAnimationDurationUserInfoKey] as! Double
        UIView.animateWithDuration(duration, animations: { () -> Void in
            self.toolbar!.transform = CGAffineTransformIdentity;
            self.tableView.height = self.tableView.height + self.keyboardH

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
            
            cell = MessageDetailCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: ID)
        }
        
        let message = messages![indexPath.row] as! DreamMessage
        let messageFrame = messagesFrame![indexPath.row] as! MessageDetailViewFrame

        cell?.setupDetailContent(messageFrame,senderImageFilePath: self.user!.avatar_large)

        return cell!
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        self.view.endEditing(true)
        self.keyboardH = 0
    }
    
    func gotoEndTableViewCell(){
        

        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64( 0.5 * Float(NSEC_PER_SEC) )) , dispatch_get_main_queue()) { () -> Void in
            
            if self.messages == nil {
                return
            }
            
            let lastRow = NSIndexPath(forRow: self.messages!.count - 1 , inSection: 0)
            self.tableView.scrollToRowAtIndexPath(lastRow, atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
        }
        
        if reloading {
            reloading = false
            finishLoading(0.5)
        }

    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if  messagesFrame != nil {
            return (messagesFrame![indexPath.row] as! MessageDetailViewFrame).frame.height
        }
        return 0
    }
    
    
    
    func msgToolbarButtonClick(tag:Int){
        
        let type = MsgToolbarButtonType()
        switch(tag){
        case type.voice:
            print("voice")
        case type.emotion:
            openEmotion()
        case type.add:
            print("add")
        default:
            break
        }
        
    }
    
    func openEmotion(){
        
        self.isChangingKeyboard = true
        
        if self.toolbar.textContent.inputView == nil {
            self.toolbar.textContent.inputView = self.keyboard
            self.toolbar?.setTheEmotionButton(false)
        }else{
            self.toolbar.textContent.inputView = nil
            self.toolbar?.setTheEmotionButton(true)
            
        }
        
        
        
        self.toolbar.textContent.resignFirstResponder()
        self.isChangingKeyboard = false
        let delayInSeconds:Int64 =  100000000  * 1
        var time:dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW,delayInSeconds)
        
        dispatch_after(time, dispatch_get_main_queue()) { () -> Void in
            
            let a = self.toolbar.textContent.becomeFirstResponder()
            
        }
        
    }
    
    func sendMessage() {
        self.view.endEditing(true)
        self.keyboardH = 0
        setupProgressView()
        dealWithNewItem()
        reloading = true
        tableView.reloadData()
        gotoEndTableViewCell()

    }
    
    func dealWithNewItem(){
        
        if messages != nil {
        
            let newMsg = DreamMessage()
            
            newMsg.msg_id = -1;
            newMsg.receiver_id = (messages![0] as! DreamMessage).sender_id
            newMsg.sender_id = Account.getUid()
            newMsg.created_at = TimeTool.createCurrentTime()
            newMsg.attrText = self.toolbar.textContent.attributedText
            newMsg.isRight = true
            
            
            let arr = NSMutableArray()
            arr.addObjectsFromArray(messages! as [AnyObject])
            arr.addObject(newMsg)
            
            self.messages = arr

            
        }
        self.toolbar.finishChange()
        
        
    }

}
