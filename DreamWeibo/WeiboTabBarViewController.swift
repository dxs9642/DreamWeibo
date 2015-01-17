 //
//  WeiboViewController.swift
//  DreamWeibo
//
//  Created by 孙龙霄 on 1/15/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

import UIKit

class WeiboTabBarViewController: UITabBarController ,PlusButtonProtocol{


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addAllChildVCs()
        addCustomTabBar()

        
        // Do any additional setup after loading the view.
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
        self.presentViewController(nav, animated: true,nil)
    }


    func addAllChildVCs(){
        var home = HomeViewController()
        self.addChildVC(home, title: "首页", image: "tabbar_home_os7", select_image: "tabbar_home_selected_os7")
        
        
        var message = MessageViewController()
        self.addChildVC(message, title: "消息", image: "tabbar_message_center_os7", select_image: "tabbar_message_center_selected_os7")
        
        
        var discover = DiscoverViewController()
        self.addChildVC(discover, title: "发现", image: "tabbar_discover_os7", select_image: "tabbar_discover_selected_os7")
        
        var profile = ProfileViewController()
        self.addChildVC(profile, title: "我", image: "tabbar_profile_os7", select_image: "tabbar_profile_selected_os7")
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
