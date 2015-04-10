//
//  MessageDetailView.swift
//  DreamWeibo
//
//  Created by 孙龙霄 on 4/6/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

import UIKit

class MessageDetailView: UIImageView {

    
    
    var message:DreamMessage!
    let timeLabel = UILabel()
    let userImage = UIImageView()
    let msgButton = UIButton()
    var senderImageFilePath:NSString!
    var showTime:Bool!{
        didSet{
            if showTime! {
                timeLabel.text = TimeTool.dealwithTime(message.created_at)
            }
        }
    }
    var isSender = false
    

    convenience init(senderImageFilePath:NSString){
        
        let frame = CGRectMake(0, 0, 0, 0)
        self.init(frame:frame)
        self.senderImageFilePath = senderImageFilePath


        var arr = senderImageFilePath.componentsSeparatedByString("/")
        
        let userId:NSString = arr[3] as! NSString
        
        let filePath = (((NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true) as NSArray).lastObject as! NSString) as String)+"/"+(userId as String)+".jpg"
        
        let fm = NSFileManager.defaultManager()
        
        if fm.fileExistsAtPath(filePath){
            
            let image = UIImage(contentsOfFile: filePath)
            userImage.image = image
            self.addSubview(userImage)
        }
        

        
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.userInteractionEnabled = true
        
        timeLabel.textColor = UIColor.lightGrayColor()
        self.addSubview(timeLabel)
        
        
        self.addSubview(msgButton)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }



    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.width = self.superview!.width
        self.height = self.superview!.height

        let font = DreamFont()

        if showTime! {
            
            timeLabel.font = font.DreamStatusOrginalNameFont
            let boundingSize = CGSizeMake(self.frame.size.width, CGFloat.max)
            var attr = NSMutableDictionary()
            attr[NSFontAttributeName] = font.DreamStatusOrginalNameFont
            
            let theName:NSString = timeLabel.text!
            let nameSize = theName.boundingRectWithSize(boundingSize, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: attr as [NSObject : AnyObject], context: nil)
            timeLabel.size = nameSize.size
            timeLabel.centerX = self.width / 2
            timeLabel.y = 5
            
            
        }
        
        userImage.x = 10
        userImage.y = CGRectGetMaxY(timeLabel.frame)
        userImage.width = 30
        userImage.height = userImage.width
        
        let showMessage = message.text
        msgButton.titleLabel?.font = font.DreamStatusOrginalNameFont
        let boundingSize = CGSizeMake(200, CGFloat.max)
        var attr = NSMutableDictionary()
        attr[NSFontAttributeName] = font.DreamStatusOrginalNameFont
        let text:NSString = showMessage
        let textSize = text.boundingRectWithSize(boundingSize, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: attr as [NSObject : AnyObject], context: nil)
        msgButton.x = CGRectGetMaxX(userImage.frame)
        msgButton.y = userImage.y
        msgButton.width = textSize.width + 10
        msgButton.height = textSize.height + 5
        msgButton.setTitle(message.text, forState: UIControlState.Normal)
        msgButton.setTitle(message.text, forState: UIControlState.Highlighted)
        msgButton.titleLabel?.textColor = UIColor.blackColor()
        msgButton.setBackgroundImage(UIImage.resizeparticularImage("messages_left_bubble"), forState: UIControlState.Normal)
        
        msgButton.setBackgroundImage(UIImage.resizeparticularImage("messages_left_bubble_highlighted"), forState: UIControlState.Highlighted)

        
    }

}
