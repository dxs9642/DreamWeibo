//
//  AppDelegate.swift
//  DreamWeibo
//
//  Created by 孙龙霄 on 1/15/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,BMKGeneralDelegate {
    
    var window: UIWindow?
    var mapManager:BMKMapManager!
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        
        
        window = UIWindow()
        window?.frame = UIScreen.mainScreen().bounds
        
        
        var defaults = NSUserDefaults()
        let lastVersion = defaults.objectForKey("last_version") as NSString?
        let dictionary =  NSBundle.mainBundle().infoDictionary! as NSDictionary
        let currentVersion = dictionary[String(kCFBundleVersionKey)] as NSString
        let accessToken = defaults.objectForKey("accessToken") as NSString?
        
        
        
        if currentVersion == lastVersion{
            if accessToken != nil {
                self.window?.rootViewController = MainViewController()
//                self.window?.rootViewController = WeiboTabBarViewController()
            }else{
                self.window?.rootViewController = OauthViewController()
            }
        }else{
            defaults.setValue(currentVersion, forKey: "last_version")
            defaults.synchronize()
            self.window?.rootViewController = NewFeatureViewController()
        }
        
        setupLocalNotification()
        setupNavigationBarAppearance()
        setupBarButtonItemAppearance()
        
        window?.makeKeyAndVisible()
        
        setupNetwokMonitor()
        


        setupBaiduMapManager()
//        setupLocalNotification()
        
        
        return true
        
    }
    
    
    
    func setupLocalNotification(){
//
        let settings = UIUserNotificationSettings(forTypes: UIUserNotificationType.Badge | UIUserNotificationType.Alert | UIUserNotificationType.Sound , categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(settings)
//
//        let ln = UILocalNotification()
//        ln.soundName = ""
//        ln.alertBody = "good News"
//        ln.alertAction = "good News"
//        ln.timeZone = NSTimeZone.defaultTimeZone()
//        ln.fireDate = NSDate(timeIntervalSinceNow: 5)
//        ln.repeatInterval = NSCalendarUnit.MonthCalendarUnit
//        UIApplication.sharedApplication().scheduleLocalNotification(ln)
//
    }
    
    
    func setupNetwokMonitor(){
        var mgr = AFNetworkReachabilityManager.sharedManager()
        mgr.setReachabilityStatusChangeBlock { (status:AFNetworkReachabilityStatus) -> Void in
            switch (status) {
            case AFNetworkReachabilityStatus.Unknown: // 未知网络
                break
            case AFNetworkReachabilityStatus.NotReachable: // 没有网络(断网)
                MBProgressHUD.showError("网络异常，请检查网络设置")
            case AFNetworkReachabilityStatus.ReachableViaWWAN: // 手机自带网络
                MBProgressHUD.showMessage("当前状态下使用流量")
                let delayInSeconds:Int64 =  1000000000  * 1
                var popTime:dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW,delayInSeconds)
                dispatch_after(popTime, dispatch_get_main_queue(), {
                    MBProgressHUD.hideHUD()
                })
            case AFNetworkReachabilityStatus.ReachableViaWiFi: // WIFI
                MBProgressHUD.showMessage("已切换到WiFi状态")
                let delayInSeconds:Int64 =  1000000000  * 1
                var popTime:dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW,delayInSeconds)
                dispatch_after(popTime, dispatch_get_main_queue(), {
                    MBProgressHUD.hideHUD()
                })
            }
        }
        mgr.startMonitoring()
    }
    
    func setupNavigationBarAppearance(){
        var apperance = UINavigationBar.appearance()
        var textAttrs = NSMutableDictionary()
        textAttrs[NSFontAttributeName] = UIFont.systemFontOfSize(20)
        //        textAttrs[NSShadowAttributeName] = NSValue(UIOffset: UIOffsetZero)
        //          这个方法不能在这里设置，设置程序崩溃，不知道为啥，不管了
        apperance.titleTextAttributes = textAttrs
        
    }
    
    
    func setupBarButtonItemAppearance(){
        
        var apperance = UIBarButtonItem.appearance()
        var disableTextAttrs = NSMutableDictionary()
        disableTextAttrs[NSForegroundColorAttributeName] = UIColor.lightGrayColor()
        disableTextAttrs[NSFontAttributeName] = UIFont.systemFontOfSize(14)
        apperance.setTitleTextAttributes(disableTextAttrs, forState: UIControlState.Disabled)
        
        var helightTextAttrs = NSMutableDictionary()
        helightTextAttrs[NSForegroundColorAttributeName] = UIColor.blackColor()
        helightTextAttrs[NSFontAttributeName] = UIFont.systemFontOfSize(14)
        apperance.setTitleTextAttributes(helightTextAttrs, forState: UIControlState.Highlighted)
        
        
        var textAttrs = NSMutableDictionary()
        //        textAttrs[NSForegroundColorAttributeName] = UIColor.orangeColor()
        textAttrs[NSFontAttributeName] = UIFont.systemFontOfSize(14)
        apperance.setTitleTextAttributes(textAttrs, forState: UIControlState.Normal)
        
        
    }
    
    func setupBaiduMapManager(){
        mapManager = BMKMapManager()
        let ret = mapManager.start("7pjx7xGF4lZPmrb2HTkhG1Nm", generalDelegate: self)

    }
    
    func onGetNetworkState(iError: Int32) {
        if iError==0 {
            NSLog("联网成功")
        }else{
            NSLog("onGetNetworkState %d",iError)
        }
    }
    
    func onGetPermissionState(iError: Int32) {
        if iError==0 {
            NSLog("授权成功")
        }else{
            NSLog("onGetPermissionState %d",iError)
        }
    }


    
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        //这个过期的时间是不稳定的，也就是谁然在后台运行，但是系统运行这个程序一段时间就停止，这也是为什么pp助手使用音乐播放功能无线延长后台运行时间
       
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func applicationDidReceiveMemoryWarning(application: UIApplication) {
        SDImageCache.sharedImageCache().clearMemory()
        SDWebImageManager.sharedManager().cancelAll()
    }
    
    
}

