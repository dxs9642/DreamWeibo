//
//  Account.swift
//  DreamWeibo
//
//  Created by 孙龙霄 on 1/18/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

import UIKit

class Account: NSObject , NSCoding {
    
    var access_token:NSString?
    var expires_in:NSString?
    var uid:NSString?
    var expires_time:NSDate?

    
    override init() {
        super.init()
    }
    
    class var path:NSString {
        get{
           return  (((NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true) as NSArray).lastObject as! NSString) as String)+"/account.data"
        }
    }

    
    
    
    func setWithDictionary(dic:NSDictionary){
        let nf = NSNumberFormatter()
        access_token = dic["access_token"] as! NSString?
        expires_in = nf.stringFromNumber( dic["expires_in"] as! Float)
        uid = dic["uid"] as! NSString?
    }
    
     required init(coder aDecoder: NSCoder) {

        self.expires_time = aDecoder.decodeObjectForKey("expires_time") as! NSDate?
        self.access_token = aDecoder.decodeObjectForKey("access_token") as! NSString?
        self.expires_in = aDecoder.decodeObjectForKey("expires_in") as! NSString?
        self.uid = aDecoder.decodeObjectForKey("uid") as! NSString?
        

    }
    
    class func setName(name:NSString){
        
        var defaults = NSUserDefaults()
        defaults.setValue(name, forKey: "userInfo")
        defaults.synchronize()


    }
    
    class func getName() -> String?{
        
        var defaults = NSUserDefaults()
        return defaults.valueForKey("userInfo") as? String
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(access_token, forKey: "access_token")
        aCoder.encodeObject(expires_in, forKey: "expires_in")
        aCoder.encodeObject(uid, forKey: "uid")
        
        let now = NSDate()
        expires_time = now.dateByAddingTimeInterval(expires_in!.doubleValue)
        aCoder.encodeObject(expires_time, forKey: "expires_time")
    }
    
    class func save(account:Account){
        
        NSKeyedArchiver.archiveRootObject(account, toFile:path as String )
        
    }
    
    
    
    class func getAccount() -> Account?{
        let account = NSKeyedUnarchiver.unarchiveObjectWithFile(path as String) as! Account
        let now = NSDate()
        if now.compare(account.expires_time!) == NSComparisonResult.OrderedDescending {
            return nil
        }
        return account
    }
    
    class func expiredAndReAuth() {
        var window = UIApplication.sharedApplication().keyWindow
        window?.rootViewController = OauthViewController()

    }
    
    
    func getUserImage()->UIImage?{
        
        let filePath = (((NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true) as NSArray).lastObject as! NSString) as String)+"/account.jpg"
        
        let fm = NSFileManager.defaultManager()
        
        if fm.fileExistsAtPath(filePath){
            
            let image = UIImage(contentsOfFile: filePath)
            return image
        }
        


        
        var params = NSMutableDictionary()
        params["access_token"] = self.access_token
        params["uid"] = self.uid
        DreamHttpTool.get("https://api.weibo.com/2/users/show.json", params: params, success: { (obj:AnyObject!) -> Void in
            
            let result = obj as! NSDictionary
            
            
            let userInfo = DreamUser(keyValues: result as [NSObject : AnyObject])
            

            self.saveImage(userInfo.avatar_large)
          
            
            }) { () -> Void in
                MBProgressHUD.showError("网络未知错误")
        }
        
        
        return nil
    }
    
    func saveImage(url:NSString){
        
        let imageUrl = NSURL(string: url as String)
        let request = NSURLRequest(URL: imageUrl!)

        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler:{
        
        
        (response:NSURLResponse!,data:NSData!,error:NSError!) -> Void in
            
            let image = UIImage(data: data)
            
            let filePath = (((NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true) as NSArray).lastObject as! NSString) as String)+"/account.jpg"

            UIImageJPEGRepresentation(image, 1.0).writeToFile(filePath, atomically: true)

        })

    }
    
    
}