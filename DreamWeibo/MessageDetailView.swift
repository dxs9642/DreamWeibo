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
    var senderImageFilePath:NSString!
    let timeLabel = UILabel()
    let userImage = UIImageView()
    let msgButton = UIButton()
    var msg:DreamMessage!
    var showTime:Bool!{
        didSet{
            if showTime! {
                timeLabel.text = TimeTool.dealwithTime(message.created_at)
            }
        }
    }
    var isSender = false
    
    
    override init(){
        super.init()
        
        self.userInteractionEnabled = true
        
        timeLabel.textColor = UIColor.lightGrayColor()
        self.addSubview(timeLabel)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.width = self.superview!.width
        self.height = self.superview!.height

        
        if showTime! {
            
            let font = DreamFont()
            timeLabel.font = font.DreamStatusOrginalNameFont
            let boundingSize = CGSizeMake(self.frame.size.width, CGFloat.max)
            var attr = NSMutableDictionary()
            attr[NSFontAttributeName] = font.DreamStatusOrginalNameFont
            
            let theName:NSString = timeLabel.text!
            let nameSize = theName.boundingRectWithSize(boundingSize, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: attr, context: nil)
            timeLabel.size = nameSize.size
            timeLabel.centerX = self.width / 2
            timeLabel.y = 5
            
        }
        
        
    }

}
