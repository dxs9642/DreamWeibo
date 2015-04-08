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
    var messages:NSArray?
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
        
        let duration = dic[UIKeyboardAnimationDurationUserInfoKey] as Double
        
        UIView.animateWithDuration(duration, animations: { () -> Void in
            
            let keyboardF = (dic[UIKeyboardFrameEndUserInfoKey] as NSValue).CGRectValue()
            let keyboardH = keyboardF.size.height
            
            self.toolbar?.transform = CGAffineTransformMakeTranslation(0, -keyboardH)
            
            
        })
        
    }
    
    func keyboardWillHide(note:NSNotification){
        
        let dic = note.userInfo!
        
        let duration = dic[UIKeyboardAnimationDurationUserInfoKey] as Double
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
        let ID = "cell"
        var cell = tableView.dequeueReusableCellWithIdentifier(ID) as? MessageDetailCell
        if cell == nil {
            cell = MessageDetailCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: ID)
        }
        cell?.message = messages![indexPath.row] as DreamMessage
        cell?.senderImageFilePath = self.user!.avatar_large
        if indexPath.row - 1 > 0 {
            let nextMessage = messages![indexPath.row - 1] as DreamMessage
            cell?.showTime = TimeTool.showTime(cell!.message.created_at, anotherTime: nextMessage.created_at)
        }
        
        return cell!
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        self.view.endEditing(true)
    }

}
