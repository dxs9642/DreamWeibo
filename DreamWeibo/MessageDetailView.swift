//
//  MessageDetailView.swift
//  DreamWeibo
//
//  Created by 孙龙霄 on 4/6/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

import UIKit

class MessageDetailView: UIImageView {

    
    

    var msgFrame:MessageDetailViewFrame?{
        didSet{
            if msgFrame!.showTime {
                timeLabel.text = TimeTool.dealwithTime(msgFrame!.message.created_at)
            }
            
            msgButton.setTitle(msgFrame!.message.text, forState: UIControlState.Normal)
            msgButton.setTitle(msgFrame!.message.text, forState: UIControlState.Highlighted)
            
        }
    }
    let timeLabel = UILabel()
    let userImage = UIImageView()
    let msgButton = UIButton()
    var senderImageFilePath:NSString!
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
        
        msgButton.titleLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
        self.addSubview(msgButton)
        
        msgButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        msgButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Highlighted)
        
        msgButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        msgButton.contentEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 5)
        msgButton.setBackgroundImage(UIImage.resizeparticularImage("messages_left_bubble"), forState: UIControlState.Normal)
        
        msgButton.setBackgroundImage(UIImage.resizeparticularImage("messages_left_bubble_highlighted"), forState: UIControlState.Highlighted)

    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }



    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if msgFrame == nil {
            return
        }
        
        let font = DreamFont()

        self.frame = msgFrame!.frame

        timeLabel.frame = msgFrame!.timeFrame
        timeLabel.font = font.DreamSimpleTimeFont
        userImage.frame = msgFrame!.imageFrame
        
        
        msgButton.titleLabel?.font = font.DreamStatusOrginalTimeFont

        
        msgButton.frame = msgFrame!.msgButtonFrame
        


        
    }

}
