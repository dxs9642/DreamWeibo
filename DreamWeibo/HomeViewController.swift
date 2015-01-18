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
    var statuses:NSArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        loadNewStatus()
        
    }
    
    func loadNewStatus(){
        
        let account = Account.getAccount()
        if account == nil {
            Account.expiredAndReAuth()
        }
        
        var mgr = AFHTTPRequestOperationManager()
        
        var params = NSMutableDictionary()
        params["access_token"] = account!.access_token
        //我哩个去，就错了一个地方。。。。。http://www.dream.net多加了最后的反斜线就错了
        
        mgr.GET("https://api.weibo.com/2/statuses/home_timeline.json", parameters: params, success: { (operation:AFHTTPRequestOperation! , obj:AnyObject!) -> Void in
            
            let result = obj as NSDictionary
            

            let statusDictArray = result["statuses"] as NSArray
            
            self.statuses = DreamStatus.objectArrayWithKeyValuesArray(statusDictArray)
            
            self.tableView.reloadData()
            
            }) { (operation:AFHTTPRequestOperation!, error:NSError!) -> Void in
                
                print("failed")
        }
    
    

    }


    func setupNavigationBar(){
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.initBarButtonItem("navigationbar_friendsearch", imageHighlight: "navigationbar_friendsearch_highlighted", target:self,action: "friendSearch")
        
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.initBarButtonItem("navigationbar_pop", imageHighlight: "navigationbar_pop_highlighted", target:self ,action: "pop")
        
        var titleButton = DreamTitleButton()
        self.titleButton = titleButton
        titleButton.setTitle("清梦的未来", forState: UIControlState.Normal)
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
        
        if statuses==nil{
            return 0
        }
        else{
            return self.statuses!.count
        }
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "")
        if statuses != nil {
            let status = statuses![indexPath.row] as DreamStatus
            cell.textLabel?.text = status.text
            
            let user = status.user
            let imageUrlStr = user?.profile_image_url
            cell.imageView?.setImageWithURL(NSURL(string: imageUrlStr!), placeholderImage: UIImage(named: "avatar_default_small"))
        }
        return cell
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
    


}
