//
//  HomeTableViewController.swift
//  DreamWeibo
//
//  Created by 孙龙霄 on 1/15/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

import UIKit

class HomeViewController: UITableViewController,DreamMenuProtocol{

    var titleButton:UIButton?
    var statusFrame:NSMutableArray = NSMutableArray()
    var footer:DreamLoadMoreFooter?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.backgroundColor = UIColor(red: 211/255, green: 211/255, blue: 211/255, alpha: 1.0)
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        setupNavigationBar()
        setupRefresh()
        self.refreshControl?.beginRefreshing()
        loadNewStatus()
        setupUserInfo()
        
        
    }
    
    func setupUserInfo(){
        

            
        
            let account = Account.getAccount()
            if account == nil {
                Account.expiredAndReAuth()
            }
            
        
            var params = NSMutableDictionary()
            params["access_token"] = account!.access_token
            
            params["uid"] = account!.uid
        
            DreamHttpTool.get("https://api.weibo.com/2/users/show.json", params: params, success: { (obj:AnyObject!) -> Void in
                
                let result = obj as NSDictionary
                
                
                let userInfo = DreamUser(keyValues: result)
                
                Account.setName(userInfo.name)
                
                self.titleButton?.setTitle(userInfo.name , forState: UIControlState.Normal)
                
                let length = countElements(userInfo.name)*20 + 30
                self.titleButton?.setWidth(CGFloat(Float(length)))
                
                self.dismissViewControllerAnimated(true, completion: nil)

            }) { () -> Void in
                MBProgressHUD.showError("网络未知错误")
                self.titleButton?.setTitle(Account.getName()!, forState: UIControlState.Normal)
                self.dismissViewControllerAnimated(true, completion: nil)
                
            }
        
    

        
    }
    
    func setupRefresh(){
        var refreshControl = UIRefreshControl()
        self.refreshControl = refreshControl
        self.tableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: "refreshData", forControlEvents: UIControlEvents.ValueChanged)
        
        self.footer = DreamLoadMoreFooter.footer()
        
        self.tableView.tableFooterView = self.footer
        
    }
    
    func refreshData(){
        loadNewStatus()
        
    }
    
    func loadNewStatus(){
        
        
        
        let account = Account.getAccount()
        if account == nil {
            Account.expiredAndReAuth()
        }
        
        
        var params = NSMutableDictionary()
        params["access_token"] = account!.access_token
        
        let firstStatusFrame = self.statusFrame.firstObject as DreamStatusFrame?
        let firstStatus = firstStatusFrame?.status
        
        if firstStatus != nil {
            params["since_id"] = firstStatus!.idstr
        }
 
        DreamHttpTool.get("https://api.weibo.com/2/statuses/home_timeline.json", params: params, success: { (obj:AnyObject!) -> Void in
            let result = obj as NSDictionary
            
            
            let statusDictArray = result["statuses"] as NSArray
            
            
            let newStatus = NSMutableArray( array: DreamStatus.objectArrayWithKeyValuesArray(statusDictArray))
            let newFrames = self.statusesFramesWithStatuses(newStatus)
            
            if newFrames.count != 0 {
                let range = NSMakeRange(0, newStatus.count)
                self.statusFrame.insertObjects(newFrames, atIndexes:NSIndexSet(indexesInRange:range))
                self.tableView.reloadData()
            }
            if self.tabBarItem.badgeValue != nil{
                UIApplication.sharedApplication().applicationIconBadgeNumber -= self.tabBarItem!.badgeValue!.toInt()!
            }
            self.tabBarItem.badgeValue = nil
            self.showStatusCount(newStatus.count)
            self.refreshControl?.endRefreshing()

            let firstRow = NSIndexPath(forRow: 0, inSection: 0)
            self.tableView.scrollToRowAtIndexPath(firstRow, atScrollPosition: UITableViewScrollPosition.Top, animated: true)
            
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
    
    
    func loadMoreStatus(){
        let account = Account.getAccount()
        if account == nil {
            Account.expiredAndReAuth()
        }
        
        
        var params = NSMutableDictionary()
        params["access_token"] = account!.access_token
        
        let lastStatusFrame = self.statusFrame.lastObject as DreamStatusFrame?
        let lastStatus = lastStatusFrame?.status
        
        if lastStatus != nil {
            params["max_id"] = lastStatus!.idstr.toInt()! - 1
        }
        
        DreamHttpTool.get("https://api.weibo.com/2/statuses/home_timeline.json", params: params, success: { (obj:AnyObject!) -> Void in
            
            let result = obj as NSDictionary
            
            
            let statusDictArray = result["statuses"] as NSArray
            
            

            
            let newStatus = NSMutableArray( array: DreamStatus.objectArrayWithKeyValuesArray(statusDictArray))
            let newFrames = self.statusesFramesWithStatuses(newStatus)
            
            
            if newFrames.count != 0 {
                self.statusFrame.addObjectsFromArray(newFrames)
                self.tableView.reloadData()
            }

            self.footer?.endRefreshing()

            
        }) { () -> Void in
            
        }
        


    }
    
    
    func showStatusCount(count:Int){
        var label = UILabel()
        if count == 0 {
            label.text = "没有新的微博信息偶"
        }else{
            label.text = "收到新的微博信息\(count)条"
        }
        label.backgroundColor = UIColor(patternImage: UIImage(named: "timeline_new_status_background")!)
        label.textAlignment = NSTextAlignment.Center
        label.textColor = UIColor.whiteColor()
        label.setHeight(30)
        label.frame = CGRectMake(0, 63-label.height(), self.view.width(), 30)
        self.navigationController?.view.insertSubview(label, belowSubview: self.navigationController!.navigationBar)
        
        let duration:NSTimeInterval = 1.0
        
 
        
        UIView.animateWithDuration(duration, animations: { () -> Void in
            label.transform = CGAffineTransformMakeTranslation(0, label.height())
            label.alpha = 1.0
        }) { (isFinish:Bool) -> Void in
            let delay:NSTimeInterval = 1.0
            
            UIView.animateWithDuration(duration, delay: delay, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                label.transform = CGAffineTransformIdentity
                label.alpha = 0.0
                }, completion: { (isFinished:Bool) -> Void in
                    label.removeFromSuperview()
            })

        }
        
        
    }


    func setupNavigationBar(){
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.initBarButtonItem("navigationbar_friendsearch", imageHighlight: "navigationbar_friendsearch_highlighted", target:self,action: "friendSearch")
        
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.initBarButtonItem("navigationbar_pop", imageHighlight: "navigationbar_pop_highlighted", target:self ,action: "pop")
        
        var titleButton = DreamTitleButton()
        self.titleButton = titleButton
        if Account.getName() != nil {
            titleButton.setTitle(Account.getName()!, forState: UIControlState.Normal)
        }else{
            titleButton.setTitle("首页", forState: UIControlState.Normal)
        }
        titleButton.setImage(UIImage(named: "navigationbar_arrow_down"), forState: UIControlState.Normal)
        titleButton.tag = 100
        titleButton.addTarget(self, action: "titleClick:", forControlEvents: UIControlEvents.TouchUpInside)
        //        titleButton.setBackgroundImage(UIImage(named: "navigationbar_background"), forState: UIControlState.Selected)  这句话没效果。。。。
        titleButton.setHeight(30)
        let str = titleButton.titleLabel?.text
        let length = countElements(str!)*20 + 30
        titleButton.setWidth(CGFloat(Float(length)))
        self.navigationItem.titleView = titleButton

    }
    
    
    func titleClick(sender:UIButton){
        if sender.tag == 100 {
            sender.tag = 101
            sender.setImage(UIImage(named: "navigationbar_arrow_up"), forState: UIControlState.Normal)
        }else{
            sender.tag = 100
            sender.setImage(UIImage(named: "navigationbar_arrow_down"), forState: UIControlState.Normal)
        }
        var button = UIButton()
        button.backgroundColor = UIColor.redColor()
        var menu = DreamPopMenu().initPopMenu(button)
        menu.delegate = self
        menu.showInRect(CGRectMake(100, 100, 200, 100))
        menu.setDimBackground(true)
        menu.setArrowPosition(DreamMenuArrorPosition.HMPopMenuArrowPositionCenter )
    }
    

    
    func friendSearch(){
        
    }

    func pop(){

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.

        tableView.tableFooterView?.hidden = (statusFrame.count==0) ? true : false
        return self.statusFrame.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = DreamStatusCell.cellWithTableView(tableView)
        cell!.setupStatusFrame(self.statusFrame[indexPath.row] as DreamStatusFrame)
        
        return cell!
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var newView = UIViewController()
        newView.view.backgroundColor = UIColor.purpleColor()
        newView.title = "微博正文"
        self.navigationController?.pushViewController(newView, animated: true)
    }
    
    func popMenuDidDismissed(popMenu:DreamPopMenu){
        if self.titleButton!.tag == 100 {
            self.titleButton!.tag = 101
            self.titleButton!.setImage(UIImage(named: "navigationbar_arrow_up"), forState: UIControlState.Normal)
        }else{
            self.titleButton!.tag = 100
            self.titleButton!.setImage(UIImage(named: "navigationbar_arrow_down"), forState: UIControlState.Normal)
        }
    }
    

    override func scrollViewDidScroll(scrollView: UIScrollView) {
        
        if self.statusFrame.count==0 || self.footer!.refreshing {
            return
        }
        
        var delta = scrollView.contentSize.height - scrollView.contentOffset.y
        
        var sawFooterH = self.view.height() - self.tabBarController!.tabBar.height()
        
        if delta <= sawFooterH {
            self.footer?.beginRefreshing()
            self.loadMoreStatus()
        }
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let frame = self.statusFrame[indexPath.row] as DreamStatusFrame
        return frame.cellHeight
    }
    
}
