 //
//  WeiboViewController.swift
//  DreamWeibo
//
//  Created by 孙龙霄 on 1/15/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

import UIKit

class WeiboTabBarViewController: UITabBarController ,PlusButtonProtocol,UITabBarControllerDelegate{

    
    var home:HomeViewController?
    var message:MessageViewController?
    var profile:ProfileViewController?
    var changeFlag = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        addAllChildVCs()
        addCustomTabBar()
        setUnreadCount()
    

        let timer = NSTimer.scheduledTimerWithTimeInterval(10.0, target: self, selector: "setUnreadCount", userInfo: nil, repeats: true)
        
        NSRunLoop.mainRunLoop().addTimer(timer, forMode: NSRunLoopCommonModes)
        
        

    }

    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
        let vc = ((viewController as UINavigationController).viewControllers as NSArray).firstObject as UIViewController
        if vc.isKindOfClass(HomeViewController) {
            if changeFlag {
                changeFlag = false
                return
            }
            self.home?.refreshControl?.beginRefreshing()
            self.home?.refreshData()

        }else{
            changeFlag = true
        }
    }

    
    func setUnreadCount(){
        let account = Account.getAccount()
        if account == nil {
            Account.expiredAndReAuth()
        }
        
        
        var params = NSMutableDictionary()
        params["access_token"] = account!.access_token
        params["uid"] = account!.uid
        
        DreamHttpTool.get("https://rm.api.weibo.com/2/remind/unread_count.json", params: params, success: { (obj:AnyObject!) -> Void in
            
                let result = obj as NSDictionary
            
                let counts = DreamUnreadCountResult(keyValues: result) as DreamUnreadCountResult
            
                self.home?.tabBarItem.badgeValue = counts.status==0 ? nil: "\(counts.status)"
                self.message?.tabBarItem.badgeValue = counts.messageCount()==0 ? nil: "\(counts.messageCount())"
                self.profile?.tabBarItem.badgeValue = counts.follower==0 ? nil: "\(counts.follower)"
            

            
            
                UIApplication.sharedApplication().applicationIconBadgeNumber = Int(counts.totalCount())
            
            }) { () -> Void in
                
        }
        

    }
    
    func addCustomTabBar(){
        var dreamTabBar = DreamTabBar()
        dreamTabBar.plusDelegate = self
        self.setValue(dreamTabBar, forKey: "tabBar")
        self.tabBar.tintColor = UIColor.orangeColor()
    }

    
    func plusButtonClick(){
        var compose = ComposeViewController()
        compose.view.backgroundColor = UIColor.whiteColor()
        var nav = DreamNavigationViewController(rootViewController: compose)
        
        
        let mainVc = UIApplication.sharedApplication().keyWindow?.rootViewController as MainViewController
        mainVc.presentViewController(nav, animated: true,nil)
    }


    func addAllChildVCs(){
        var home = HomeViewController()
        self.addChildVC(home, title: "首页", image: "tabbar_home_os7", select_image: "tabbar_home_selected_os7")
        self.home = home
        
        var message = MessageViewController()
        self.addChildVC(message, title: "消息", image: "tabbar_message_center_os7", select_image: "tabbar_message_center_selected_os7")
        self.message = message
        
        var discover = DiscoverViewController()
        self.addChildVC(discover, title: "发现", image: "tabbar_discover_os7", select_image: "tabbar_discover_selected_os7")

        var profile = ProfileViewController()
        self.addChildVC(profile, title: "我", image: "tabbar_profile_os7", select_image: "tabbar_profile_selected_os7")
        self.profile = profile
    }
    
    
    func addChildVC(vc:UIViewController,title:NSString,image:NSString,select_image:NSString){
        
        //下面的所有代码都没有调用viewDidLoad()，因为没有加载view
        vc.title = title
        vc.tabBarItem.image = UIImage(named: image)
        var selectImage = UIImage(named: select_image)
        selectImage = selectImage?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        
        vc.tabBarItem.selectedImage = selectImage
        
        var nav = DreamNavigationViewController(rootViewController: vc)
        
        self.addChildViewController(nav)
    }

    
    override func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem!) {

        
        
    }
    

}
