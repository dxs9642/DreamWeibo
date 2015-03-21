//
//  DreamUserViewController.swift
//  DreamWeibo
//
//  Created by 孙龙霄 on 3/10/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

import UIKit

class DreamUserViewController: UIViewController{

    var userTop:UserTopView!
    var userName:NSString!
    var userInfo:DreamUser?
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.greenColor()
        loadTopView()
        setupUserInfo()

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
            
            self.userTop.didShow(self.userInfo!)
            

            
            }) { () -> Void in
                MBProgressHUD.showError("网络未知错误")

                
        }
        
        
        
        
    }



    

    func loadTopView(){
    
        userTop = UserTopView()
        
        userTop.frame = self.view.bounds
        userTop.height = 200;

        
        self.view.addSubview(userTop!)


    }
    

}
