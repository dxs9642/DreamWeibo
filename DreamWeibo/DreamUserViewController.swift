//
//  DreamUserViewController.swift
//  DreamWeibo
//
//  Created by 孙龙霄 on 3/10/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

import UIKit

class DreamUserViewController: UIViewController, UITableViewDataSource,UITableViewDelegate ,FriendProtocol{

    var userTop:UserTopView!
    var centerButtons:ButtonsView!
    var tableTopView:UIImageView!
    var tableView:UITableView!
    var userName:NSString!
    var userInfo:DreamUser?
    var uid = 0
    var statusFrame:NSMutableArray = NSMutableArray()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 211/255, green: 211/255, blue: 211/255, alpha: 1.0)
        loadTopView()
        setupUserInfo()
        setupCenterButtonView()
        setupTableView()
    }
    
    
    func loadTopView(){
        
        userTop = UserTopView()
        
        userTop.frame = self.view.bounds
        userTop.height = 220;
        
        
        self.view.addSubview(userTop!)
        
        
    }
    
    func setupCenterButtonView(){
        
        centerButtons = ButtonsView()
        
        centerButtons.delegate = self
        centerButtons.backgroundColor = UIColor.whiteColor()
        centerButtons.x = 0;
        centerButtons.y = CGRectGetMaxY(userTop.frame);
        centerButtons.width = self.view.width
        centerButtons.height = 50
        
        self.view.addSubview(centerButtons)
        
    }
    
    
    func setupTableView(){
        
        tableTopView = UIImageView()
        
        let tableDescript = UILabel()
        
        let font = DreamFont()
        
        tableDescript.font = font.DreamStatusOrginalNameFont
        let boundingSize = CGSizeMake(self.view.frame.size.width, CGFloat.max)
        var attr = NSMutableDictionary()
        attr[NSFontAttributeName] = font.DreamStatusOrginalNameFont
        let theDescript:NSString = "微博信息"
        let descriptSize = theDescript.boundingRectWithSize(boundingSize, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: attr, context: nil)
        tableDescript.size = descriptSize.size
        tableDescript.text = theDescript
        
        
        tableTopView.width = self.view.width
        tableTopView.height = 40
        
        tableDescript.centerX = tableTopView.centerX
        tableDescript.centerY = tableTopView.height / 2
        
        tableTopView.addSubview(tableDescript)
        tableTopView.image = UIImage.resizeImage("timeline_retweet_background")
        tableTopView.x = 0
        tableTopView.y = CGRectGetMaxY(centerButtons.frame)
        
        
        
        tableView = UITableView()
        
        
        tableView.x = 0
        tableView.y = CGRectGetMaxY(tableTopView.frame) - 12
        
        
        tableView.width = self.view.width
        tableView.height = self.view.height - tableView.y
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor(red: 211/255, green: 211/255, blue: 211/255, alpha: 1.0)
        self.view.addSubview(tableView)
        self.view.addSubview(tableTopView)
        
        
    }
    

    override func viewWillAppear(animated: Bool) {
        
        self.navigationController?.navigationBar.tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1);
        self.navigationController?.navigationBar.translucent = true;
        self.navigationController?.navigationBar.alpha = 0.3;

    }
    
    
    func setupUserInfo(){
        
       
        
        let account = Account.getAccount()
        if account == nil {
            Account.expiredAndReAuth()
        }
        
        
        var params = NSMutableDictionary()
        params["access_token"] = account!.access_token
        
        params["screen_name"] = userName
        
        DreamHttpTool.get("https://api.weibo.com/2/users/show.json", params: params, success: { (obj:AnyObject!) -> Void in
            
            let result = obj as NSDictionary
            
            
            self.userInfo = DreamUser(keyValues: result)
            
            
            if self.userInfo == nil {
                return
            }
            
//            self.changeTableViews()
            
            
            self.uid = result["id"] as Int
            
            self.getUserOtherInfo("\(self.uid)")
            self.getUserIsFollowMe(self.uid)
            self.loadNewStatus()

            
            }) { () -> Void in
                MBProgressHUD.showError("网络未知错误")                
        }
        

    }

    
    func getUserOtherInfo(uid:NSString){
        
        let account = Account.getAccount()
        if account == nil {
            Account.expiredAndReAuth()
        }
        
        
        var params = NSMutableDictionary()
        params["access_token"] = account!.access_token
        
        params["uids"] = uid
        
        DreamHttpTool.get("https://api.weibo.com/2/users/counts.json", params: params, success: { (obj:AnyObject!) -> Void in
            
            let result = obj as NSArray
            
            let followers_count = (result[0] as NSDictionary)["followers_count"] as Int
            
            self.userInfo?.followers_count = Int32(followers_count)
            
            let friends_count = (result[0] as NSDictionary)["friends_count"] as Int
            
            self.userInfo?.friends_count = Int32(friends_count)
            
            self.userTop.didShow(self.userInfo!)
            
            
            }) { () -> Void in
                MBProgressHUD.showError("网络未知错误")
                
                
        }

    }

    func getUserIsFollowMe(uid:Int){
        
        
        let account = Account.getAccount()
        if account == nil {
            Account.expiredAndReAuth()
        }
        
        
        var params = NSMutableDictionary()
        params["access_token"] = account!.access_token
        
        
        
        params["source_id"] = account?.uid
        params["target_id"] = uid
    
        
        DreamHttpTool.get("https://api.weibo.com/2/friendships/show.json", params: params, success: { (obj:AnyObject!) -> Void in
            
            let result = obj as NSDictionary
            
            let isFollowed = (result["source"] as NSDictionary)["following"] as Int
            
            if isFollowed == 1 {
                
                self.centerButtons.setupIsFollowing(true)
                
            }else{
                
                self.centerButtons.setupIsFollowing(false)
                
            }
            
            
            }) { () -> Void in
                MBProgressHUD.showError("网络未知错误")
                
                
        }

    }


    

    
    func FriendAbortClick(){
        
        let account = Account.getAccount()
        if account == nil {
            Account.expiredAndReAuth()
        }
        
        
        var params = NSMutableDictionary()
        params["access_token"] = account!.access_token
        
        params["uid"] = uid
        
        
        DreamHttpTool.post("https://api.weibo.com/2/friendships/destroy.json", params: params, success: { (obj:AnyObject!) -> Void in
            
                self.centerButtons.setupIsFollowing(false)
            
            }) { () -> Void in
                MBProgressHUD.showError("网络未知错误")
        }

    }
    
    func FriendAddClick() {
        
        let account = Account.getAccount()
        if account == nil {
            Account.expiredAndReAuth()
        }
        
        
        var params = NSMutableDictionary()
        params["access_token"] = account!.access_token
        
        params["uid"] = uid
        
        
        DreamHttpTool.post("https://api.weibo.com/2/friendships/create.json", params: params, success: { (obj:AnyObject!) -> Void in
            
                self.centerButtons.setupIsFollowing(true)
            
            }) { () -> Void in
                MBProgressHUD.showError("网络未知错误")
        }
        
    }
    
    
    func loadNewStatus(){
        let account = Account.getAccount()
        if account == nil {
            Account.expiredAndReAuth()
        }
        
        
        var params = NSMutableDictionary()
        params["access_token"] = account!.access_token
        
        //没有通过审核的用户uid只能是当前登录的用户，此处只做演示
        params["uid"] = account?.uid
        
        
        DreamHttpTool.get("https://api.weibo.com/2/statuses/user_timeline.json", params: params, success: { (obj:AnyObject!) -> Void in
            let result = obj as NSDictionary
            
            let statusDictArray = result["statuses"] as NSArray
            
            self.doWithNewResults(statusDictArray)
            
            
            }) { () -> Void in
                
        }
        
    }
    
    
    func statusesFramesWithStatuses(statuses:NSArray) -> NSArray{
        var frames =  NSMutableArray()
        for statuss in statuses {
            let status = statuss as DreamStatus
            var frame = DreamStatusFrame()
            frame.status = status
            frames.addObject(frame)
        }
        return frames
    }
    
    func doWithNewResults(status:NSArray){
        
        
        let newStatus =  DreamStatus.objectArrayWithKeyValuesArray(status)
        
        let newFrames = self.statusesFramesWithStatuses(newStatus)
        
        
        if newFrames.count != 0 {
            
            
            let range = NSMakeRange(0, newStatus.count)
            self.statusFrame.insertObjects(newFrames, atIndexes:NSIndexSet(indexesInRange:range))
            
            self.tableView.reloadData()
        }
        
        
    }


    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.statusFrame.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let ID = "userInfo"
        
        
        
        var cell = tableView.dequeueReusableCellWithIdentifier(ID) as DreamStatusCell?
        
        if cell == nil{
            cell = DreamStatusCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: ID)
        }
        
        cell!.setupStatusFrame(self.statusFrame[indexPath.row] as DreamStatusFrame)
        
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let detail = DreamStatusDetailViewController()
        let frame = self.statusFrame[indexPath.row] as DreamStatusFrame
        detail.status = frame.status
        self.navigationController?.pushViewController(detail, animated: true)
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let frame = self.statusFrame[indexPath.row] as DreamStatusFrame
        return frame.cellHeight
    }
    

    

}
