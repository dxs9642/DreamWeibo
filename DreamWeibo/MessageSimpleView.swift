//
//  MessageSimpleView.swift
//  DreamWeibo
//
//  Created by 孙龙霄 on 4/2/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

import UIKit

class MessageSimpleView: UIImageView {

    
    var userImage:UIImageView!
    var userTitle:UILabel!
    var detailInfo:UILabel!
    var timeLabel:UILabel!
    var type = -1
    var user:DreamUser?
    var lastMessage:NSString?
    var badgView = DreamBadgeView()
    var lastTime:NSString?
    
    convenience init(type:NSInteger){
        self.init()
        self.type = type
        self.userInteractionEnabled = true
        
        setupUserImage(type)
        setupUserTitle(type)
        
        badgView.hidden = true
        self.addSubview(badgView)
        
        timeLabel = UILabel()
        self.addSubview(timeLabel)
        
    }
        
    

    
    func setupUserImage(type:NSInteger){
        userImage = UIImageView()
        self.addSubview(userImage)
        
        switch(type){
        case 0:
            userImage.image =  UIImage(named: "messagescenter_at")
            break;
        case 1:
            userImage.image =  UIImage(named: "messagescenter_comments")
            break;
        case 2:
            userImage.image =  UIImage(named: "messagescenter_good")
            break;
        default:
            userImage.image = UIImage(named: "default_avatar")
        }
    }

    
    func setupUserTitle(type:NSInteger){
        
        userTitle = UILabel()
        self.addSubview(userTitle)
        detailInfo = UILabel()
        self.addSubview(detailInfo)
        
        switch(type){
        case 0:
            userTitle.text = "@我的"
            break;
        case 1:
            userTitle.text = "评论"
            break;
        case 2:
            userTitle.text = "赞"
            break;
        default:
            break;
        }
        
    }
    
    
    func getUserImage(urlString:NSString){
        
        var arr = urlString.componentsSeparatedByString("/")
        
        let userId:NSString = arr[3] as! NSString
        
        let filePath = (((NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true) as NSArray).lastObject as! NSString) as String)+"/"+(userId as String)+".jpg"
        
        let fm = NSFileManager.defaultManager()
        
        if fm.fileExistsAtPath(filePath){
            
            let image = UIImage(contentsOfFile: filePath)
            self.userImage.image = image
            
        }else{
            
            
            let imageUrl = NSURL(string: urlString as String)
            let request = NSURLRequest(URL: imageUrl!)
            
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler:{
                
                
                (response:NSURLResponse!,data:NSData!,error:NSError!) -> Void in
                
                let image = UIImage(data: data)
                self.userImage.image = image
                UIImageJPEGRepresentation(image, 1.0).writeToFile(filePath, atomically: true)
                
                
            })
            
            
        }
        
    }
    
    func setupFromURL(){
        
        getUserImage(self.user!.avatar_large)
        self.userTitle.text = self.user?.name
        self.detailInfo.text = self.lastMessage as? String
        let str = TimeTool.dealwithTime(lastTime! as String) as NSString
        
    }
    
    
    func showTimes(){
        
    }

    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.width = self.superview!.width
        self.height = self.superview!.height
        
        userImage.x = 5
        userImage.y = 10
        userImage.width = 50
        userImage.height = 50
        userImage.contentMode = UIViewContentMode.ScaleAspectFit
        userImage.clipsToBounds = true
        
        
        let font = DreamFont()
        userTitle.font = font.DreamStatusOrginalNameFont
        userTitle.width = self.width - 150
        userTitle.height = self.height / 2 - 15
        userTitle.x = CGRectGetMaxX(userImage.frame) + 10
        
        if detailInfo.text != nil {
                        
            detailInfo.font = font.DreamStatusOrginalTimeFont
            detailInfo.textColor = UIColor.lightGrayColor()
            detailInfo.width = self.width - 150
            detailInfo.height = self.height / 2 - 15
            detailInfo.x = CGRectGetMaxX(userImage.frame) + 10
            userTitle.y = userImage.centerY - 2 - userTitle.height
            detailInfo.y = userImage.centerY + 2
            
            timeLabel.font = font.DreamStatusOrginalTimeFont
            timeLabel.textColor = UIColor.lightGrayColor()
            let attr = NSMutableDictionary()
            attr[NSFontAttributeName] = font.DreamStatusOrginalTimeFont
            let boundingSize = CGSizeMake(self.width, CGFloat.max)
            let timeName = timeLabel.text
            let timeSize = timeName?.boundingRectWithSize(boundingSize, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: attr as [NSObject : AnyObject], context: nil)
            if timeSize != nil {
                timeLabel.size = timeSize!.size
            }
            
            timeLabel.x = self.width - 10 - timeLabel.width
            timeLabel.y = userImage.centerY - 5 - timeLabel.height
            
            
            
        }else{
            userTitle.centerY = userImage.centerY
        }
        
        if badgView.badgeValue != nil {
            
            badgView.hidden = false
            badgView.x = self.width - 5 - badgView.width
            badgView.y = userImage.centerY + 5
            
        }
        
    }

}
