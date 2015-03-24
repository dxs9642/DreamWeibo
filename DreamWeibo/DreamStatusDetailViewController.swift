//
//  DreamStatusDetailViewController.swift
//  DreamWeibo
//
//  Created by 孙龙霄 on 1/30/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

import UIKit

class DreamStatusDetailViewController: UIViewController,UITableViewDataSource,UITableViewDelegate ,DreamTopToolbarButtonProtocol{

    var status:DreamStatus!
    var tableView:UITableView!
    var bottomToolbar:DreamStatusDetailBottomToolbar!
    lazy var toolbar = DreamStatusDetailTopToolbar.toolbar
    var comments = NSMutableArray()
    var reposts = NSMutableArray()
    var showComment = true
    var isFromRetweet = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.title = "微博正文"
        self.setupTableView()
        self.setupDetailView()
        self.setupBottomToolbar()
        self.toolbar.delegate = self
        self.toolbar.status = status
        
        loadComments()
        
    }
    

    
    func setupBottomToolbar(){
        bottomToolbar = DreamStatusDetailBottomToolbar()
        
        bottomToolbar.y = CGRectGetMaxY(self.tableView.frame)
            
            
        bottomToolbar.width = self.view.width
        bottomToolbar.height = self.view.height - self.tableView.height
        
        self.view.addSubview(bottomToolbar)
        
    }
    
    func setupTableView(){
        tableView = UITableView()
        
        tableView.width = self.view.width
        tableView.height = self.view.height - 35
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor(red: 211/255, green: 211/255, blue: 211/255, alpha: 1.0)
        self.view.addSubview(tableView)
    }
    
    
    func setupDetailView(){
        let totalView = UIView()
        let emptyView = UIView()
        totalView.width = self.tableView.width
        emptyView.width = self.tableView.width
        emptyView.height = 30
        let detailView = DreamStatusDetailView()
        let frame = DreamStatusDetailFrame()
        if self.status.retweeted_status != nil {
            self.status.retweeted_status.detail = true
        }
        self.status.statusDetail = isFromRetweet
        self.status.text = self.status.text
        
        
        frame.status = self.status
        
        
        detailView.setupDetailFrame(frame)
        detailView.height = frame.frame.size.height
        totalView.height = detailView.height + 25
        totalView.addSubview(detailView)
        emptyView.y = detailView.height
        emptyView.backgroundColor = UIColor.clearColor()
        totalView.addSubview(emptyView)
        self.tableView.tableHeaderView = totalView
        
    
        
    }
    
    
    func TopToolbarButtonClick(button:UIButton){
        switch button.tag {
        case 700:
            showComment = false
            self.tableView.reloadData()
            loadRepost()
        case 701:
            showComment = true
            self.tableView.reloadData()
            loadComments()
        default:
            break
        }
    }

    
    func loadComments(){
        
        
        
        let account = Account.getAccount()
        if account == nil {
            Account.expiredAndReAuth()
        }
        
        
        var params = NSMutableDictionary()
        params["access_token"] = account!.access_token
        if comments.count != 0 {
            params["since_id"] = (comments.firstObject as DreamComment).idstr
        }
        params["id"] = self.status.idstr
        
        DreamHttpTool.get("https://api.weibo.com/2/comments/show.json", params: params, success: { (obj:AnyObject!) -> Void in
            
            let result = obj as NSDictionary
            
            let oldComments = DreamCommentsResult(keyValues: result).comments
            let set = NSIndexSet(indexesInRange: NSMakeRange(0, oldComments.count))
            
            self.comments.insertObjects(oldComments, atIndexes: set)
            self.toolbar.reloadCommentData(self.comments.count)

            self.tableView.reloadData()
            
            }) { () -> Void in
                MBProgressHUD.showError("网络未知错误")
                
        }
        
        
    }
    func loadRepost(){
        
        let account = Account.getAccount()
        if account == nil {
            Account.expiredAndReAuth()
        }
        
        
        var params = NSMutableDictionary()
        params["access_token"] = account!.access_token
        if reposts.count != 0 {
            params["since_id"] = (reposts.firstObject as DreamStatus).idstr
        }
        
        params["id"] = self.status.idstr
        
        DreamHttpTool.get("https://api.weibo.com/2/statuses/repost_timeline.json", params: params, success: { (obj:AnyObject!) -> Void in
            
            let result = obj as NSDictionary
            
            let oldReposts = DreamRepostResult(keyValues: result).reposts
            let set = NSIndexSet(indexesInRange: NSMakeRange(0, oldReposts.count))
            
            self.reposts.insertObjects(oldReposts, atIndexes: set)
            self.toolbar.reloadRepostData(self.reposts.count)
            
            self.tableView.reloadData()
            
            }) { () -> Void in
                MBProgressHUD.showError("网络未知错误")
                
        }
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if showComment {
            return comments.count
        }else {
            return reposts.count
        }
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let ID = "cell"
        var cell = tableView.dequeueReusableCellWithIdentifier(ID) as? UITableViewCell
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: ID)
        }
        if comments.count != 0 && showComment {
            cell!.textLabel?.text = (comments[indexPath.row] as DreamComment).text

        }else{
            cell!.textLabel?.text = (reposts[indexPath.row] as DreamStatus).text

        }
        return cell!
        
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.toolbar
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.toolbar.height
    }
    

}
