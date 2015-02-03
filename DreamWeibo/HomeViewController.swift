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
    let cover = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.backgroundColor = UIColor(red: 211/255, green: 211/255, blue: 211/255, alpha: 1.0)
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        setupNavigationBar()
        setupRefresh()
        self.refreshControl?.beginRefreshing()
        loadNewStatus(true)
        setupUserInfo()
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "linkDidSelect:", name: "DreamDidSelectTextNotionfication", object: nil)

//        dic["DreamLinkText"] = touchLink?.text
//        NSNotificationCenter.defaultCenter().postNotificationName("DreamDidSelectTextNotionfication", object: nil, userInfo: dic)

    }
    
    func linkDidSelect(note:NSNotification){
        
        
        let linkText = note.userInfo!["DreamLinkText"] as NSString
        
        if linkText.hasPrefix("http"){
            
        }else{
            
        }
        
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
        loadNewStatus(false)
        
    }
    
    func loadNewStatus(isFirstTime:Bool){
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
        
        if isFirstTime{
            if loadNewOfflineStatus(params) {
                return
            }
        }
        
        DreamHttpTool.get("https://api.weibo.com/2/statuses/home_timeline.json", params: params, success: { (obj:AnyObject!) -> Void in
            let result = obj as NSDictionary
            
            
            let statusDictArray = result["statuses"] as NSArray
            
            self.AddStatusInToSqlite(statusDictArray)


            
            self.doWithNewResults(statusDictArray,fromSqlite:false)
            
            
        }) { () -> Void in
            
        }
        
    }
    
    func AddStatusInToSqlite(statues:NSArray){
        let db = DreamHttpTool.db

        for statue in statues {
            let statueDic = statue as NSDictionary
            let data = NSKeyedArchiver.archivedDataWithRootObject(statueDic)
            let status_idstr = statueDic["idstr"] as NSString
            db.executeUpdate("INSERT INTO t_home_status (status_idstr,status_dict) VALUES(?,?);",withArgumentsInArray: [status_idstr,data])
            
        }
        
    }

    
    
    func loadNewOfflineStatus(params:NSDictionary) -> Bool{
        
        let db = DreamHttpTool.db
        
        let since_id = params["since_id"] as? NSString
        let max_id = params["max_id"] as? NSInteger
        
        var resultSet:FMResultSet!
        if since_id != nil{

            resultSet =  db.executeQuery("SELECT * FROM t_home_status WHERE status_idstr > ? ORDER BY status_idstr DESC LIMIT 20;", withArgumentsInArray: [since_id!])

        }
        else if max_id != nil {
            resultSet =  db.executeQuery("SELECT * FROM t_home_status WHERE status_idstr <= ?  ORDER BY status_idstr DESC LIMIT 20;", withArgumentsInArray: [max_id!])

        }else {
            resultSet =  db.executeQuery("SELECT * FROM t_home_status ORDER BY status_idstr DESC LIMIT 20;", withArgumentsInArray: [])
        }
        
        
        
        var statuses = NSMutableArray()
        
        while resultSet.next() {
            let data =  resultSet.objectForColumnName("status_dict") as NSData
            let statusDic = NSKeyedUnarchiver.unarchiveObjectWithData(data) as NSDictionary
            
            statuses.addObject(statusDic)
            
        }
        if statuses.count == 0{
            return false
        }else{
            if since_id != nil {
                doWithNewResults(statuses,fromSqlite: true)
            }else if max_id != nil {
                doWithMoreResults(statuses, fromSqlite: true)
            }else{
                doWithNewResults(statuses, fromSqlite: true)
            }
            return true
        }
    }
    
    
    func doWithNewResults(status:NSArray,fromSqlite:Bool){
        
        
        let newStatus =  DreamStatus.objectArrayWithKeyValuesArray(status)

        let newFrames = self.statusesFramesWithStatuses(newStatus)
        
        
        
        for tmp in newFrames {
            let frame = tmp as DreamStatusFrame
            
            if frame.detailFrame.retweetedFrame != nil {
                
                let tmpframe = frame.detailFrame.retweetedFrame.frame.height
                
                let tmpname = frame.status.retweeted_status.user.name
                
            }
            
        }
        
        if newFrames.count != 0 {
            
            
            let range = NSMakeRange(0, newStatus.count)
            self.statusFrame.insertObjects(newFrames, atIndexes:NSIndexSet(indexesInRange:range))
            
            
            
            self.tableView.reloadData()
        }
        self.refreshControl?.endRefreshing()

        if fromSqlite { return }
        
        if self.tabBarItem.badgeValue != nil{
            UIApplication.sharedApplication().applicationIconBadgeNumber -= self.tabBarItem!.badgeValue!.toInt()!
        }
        self.tabBarItem.badgeValue = nil
        self.showStatusCount(newStatus.count)
        
        let firstRow = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.scrollToRowAtIndexPath(firstRow, atScrollPosition: UITableViewScrollPosition.Top, animated: true)

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
        
        if loadNewOfflineStatus(params) {
            return
        }
        
        DreamHttpTool.get("https://api.weibo.com/2/statuses/home_timeline.json", params: params, success: { (obj:AnyObject!) -> Void in
            
            let result = obj as NSDictionary
            
            
            let statusDictArray = result["statuses"] as NSArray
            
            
            self.AddStatusInToSqlite(statusDictArray)

            self.doWithMoreResults(statusDictArray,fromSqlite:false)

            

            
        }) { () -> Void in
            
        }

    }
    

    func doWithMoreResults(status:NSArray,fromSqlite:Bool){
        let newStatus = NSMutableArray( array: DreamStatus.objectArrayWithKeyValuesArray(status))
        let newFrames = self.statusesFramesWithStatuses(newStatus)
        
        
        if newFrames.count != 0 {
            self.statusFrame.addObjectsFromArray(newFrames)
            self.tableView.reloadData()
        }
        
        self.footer?.endRefreshing()

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
        let mainVc = UIApplication.sharedApplication().keyWindow?.rootViewController as MainViewController
        let tabbarVc = mainVc.initViewController as WeiboTabBarViewController

        mainVc.rightMenu.hidden = true
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            
            let firstTrans = CGAffineTransformMakeScale(0.75, 0.75)
            tabbarVc.view.transform = CGAffineTransformTranslate(firstTrans, 200, 0)
            self.cover.frame = tabbarVc.view.bounds
            self.cover.backgroundColor = UIColor.clearColor()
            self.cover.addTarget(self, action: "coverClick", forControlEvents: UIControlEvents.TouchUpInside)
            tabbarVc.view.addSubview(self.cover)
                

            
        })
        
    }

    func pop(){
        let mainVc = UIApplication.sharedApplication().keyWindow?.rootViewController as MainViewController
        let tabbarVc = mainVc.initViewController as WeiboTabBarViewController
        
        mainVc.leftMenu.hidden = true

        UIView.animateWithDuration(0.5, animations: { () -> Void in
            
            let firstTrans = CGAffineTransformMakeScale(0.75, 0.75)
            tabbarVc.view.transform = CGAffineTransformTranslate(firstTrans, -200, 0)
            self.cover.frame = tabbarVc.view.bounds
            self.cover.backgroundColor = UIColor.clearColor()
            self.cover.addTarget(self, action: "coverClick", forControlEvents: UIControlEvents.TouchUpInside)
            tabbarVc.view.addSubview(self.cover)
            
        }) { (finished) -> Void in
            mainVc.rightMenu.didShow()

        }
        

        
    }
    
    func coverClick(){
        let mainVc = UIApplication.sharedApplication().keyWindow?.rootViewController as MainViewController
        let tabbarVc = mainVc.initViewController as WeiboTabBarViewController
         UIView.animateWithDuration(0.5, animations: { () -> Void in
            tabbarVc.view.transform = CGAffineTransformIdentity
            self.cover.removeFromSuperview()
         })
        mainVc.leftMenu.hidden = false
        mainVc.rightMenu.hidden = false


    }
    
    
    
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
                
        let ID = "status"
        
        
        
        var cell = tableView.dequeueReusableCellWithIdentifier(ID) as DreamStatusCell?
        
        if cell == nil{
            cell = DreamStatusCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: ID)
        }
        
        cell!.setupStatusFrame(self.statusFrame[indexPath.row] as DreamStatusFrame)

        
        return cell!
        

    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        let detail = DreamStatusDetailViewController()
        let frame = self.statusFrame[indexPath.row] as DreamStatusFrame
        detail.status = frame.status
        self.navigationController?.pushViewController(detail, animated: true)
    
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
