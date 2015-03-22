//
//  DreamUserViewController.swift
//  DreamWeibo
//
//  Created by 孙龙霄 on 3/10/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

import UIKit

class DreamUserViewController: UIViewController, FriendProtocol{

    var userTop:UserTopView!
    var centerButtons:ButtonsView!
    var userName:NSString!
    var userInfo:DreamUser?
    var uid = 0
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        loadTopView()
        setupUserInfo()
        setupCenterButtonView()

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
            
            
            
            self.uid = result["id"] as Int
            
            self.getUserOtherInfo("\(self.uid)")
            self.getUserIsFollowMe(self.uid)
            
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


    

    func loadTopView(){
    
        userTop = UserTopView()
        
        userTop.frame = self.view.bounds
        userTop.height = 220;

        
        self.view.addSubview(userTop!)


    }
    
    func setupCenterButtonView(){
        
        centerButtons = ButtonsView()
        
        centerButtons.delegate = self
        
        centerButtons.x = 0;
        centerButtons.y = CGRectGetMaxY(userTop.frame) + 10;
        centerButtons.width = self.view.width
        centerButtons.height = 50
        
        self.view.addSubview(centerButtons)
        
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
    

}
