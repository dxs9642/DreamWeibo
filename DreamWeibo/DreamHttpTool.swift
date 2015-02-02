  //
//  DreamHttpTool.swift
//  DreamWeibo
//
//  Created by 孙龙霄 on 1/19/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

import UIKit

class DreamHttpTool: NSObject {
    
    
    class var db:FMDatabase{
        get{
            let doc = (NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true) as NSArray).lastObject as NSString
            let filename = doc.stringByAppendingPathComponent("status.sqlite")
            let db = FMDatabase(path: filename)
            
            if db.open() {
                let result = db.executeUpdate("CREATE TABLE IF NOT EXISTS t_home_status(status_idstr text PRIMARY KEY NOT NULL,status_dict blob NOT NULL);",withArgumentsInArray: [])
                
//                if result {
//                    println("success")
//                }else{
//                    println("failed")
//                }
            }
            
            return db
        }
    }

   
    class func get(url:NSString,params:NSDictionary,success:(AnyObject!)->Void,errors:()->Void){
        

        var mgr = AFHTTPRequestOperationManager()
        
        
        mgr.GET(url, parameters: params, success: { (operation:AFHTTPRequestOperation! , obj:AnyObject!) -> Void in
            
            success(obj)
            
            }) { (operation:AFHTTPRequestOperation!, error:NSError!) -> Void in

            errors()
            
        }
        
        
    }
    
    class func post(url:NSString,params:NSDictionary,success:(AnyObject!)->Void,errors:()->Void){
        
        var mgr = AFHTTPRequestOperationManager()
        
        
        mgr.POST(url, parameters: params, success: { (operation:AFHTTPRequestOperation! , obj:AnyObject!) -> Void in
            
            success(obj)
            
            }) { (operation:AFHTTPRequestOperation!, error:NSError!) -> Void in
                
                errors()
                
        }

    }
    
    
}
