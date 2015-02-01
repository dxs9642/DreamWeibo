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
                let result = db.executeUpdate("CREATE TABLE IF NOT EXIST t_home_status(id integer PRIMARY KEY AUTOINCREMENT, uid text NOT NULL, status_idstr text NOT NULL,status_dic blob NOT NULL);",withArgumentsInArray: [])
                
                if result {
                    println("success")
                }else{
                    println("failed")
                }
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
    
    
//    class func postWithData(url:NSString,params:NSDictionary,success:(AnyObject!)->Void,errors:()->Void){
//        
//        var mgr = AFHTTPRequestOperationManager()
//        mgr.POST(<#URLString: String!#>, parameters: <#AnyObject!#>, constructingBodyWithBlock: <#((AFMultipartFormData!) -> Void)!##(AFMultipartFormData!) -> Void#>, success: <#((AFHTTPRequestOperation!, AnyObject!) -> Void)!##(AFHTTPRequestOperation!, AnyObject!) -> Void#>, failure: <#((AFHTTPRequestOperation!, NSError!) -> Void)!##(AFHTTPRequestOperation!, NSError!) -> Void#>)
//        
//    }
    
}
