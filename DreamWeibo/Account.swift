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
           return  ((NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true) as NSArray).lastObject as NSString)+"/account.data"
        }
    }

    
    func setWithDictionary(dic:NSDictionary){
        let nf = NSNumberFormatter()
        access_token = dic["access_token"] as NSString?
        expires_in = nf.stringFromNumber( dic["expires_in"] as Float)?
        uid = dic["uid"] as NSString?
    }
    
     required init(coder aDecoder: NSCoder) {

        self.expires_time = aDecoder.decodeObjectForKey("expires_time") as NSDate?
        self.access_token = aDecoder.decodeObjectForKey("access_token") as NSString?
        self.expires_in = aDecoder.decodeObjectForKey("expires_in") as NSString?
        self.uid = aDecoder.decodeObjectForKey("uid") as NSString?
        

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
        
        NSKeyedArchiver.archiveRootObject(account, toFile:path )
        
    }
    
    class func getAccount() -> Account?{
        let account = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as Account
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
    
}