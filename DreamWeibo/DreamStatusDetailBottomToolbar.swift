//
//  DreamStatusDetailTopToolbar.swift
//  DreamWeibo
//
//  Created by 孙龙霄 on 1/30/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

import UIKit

class DreamStatusDetailBottomToolbar: UIView {

    var repostButton:UIButton?
    var commentButton:UIButton?
    var attitudesButton:UIButton?

    
    override init() {
        super.init()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        self.repostButton = setupButtonWithIcon("timeline_icon_retweet", title: "转发")
        self.commentButton = setupButtonWithIcon("timeline_icon_comment", title: "评论")
        self.attitudesButton = setupButtonWithIcon("timeline_icon_unlike", title: "赞")

    }
    
    func setupButtonWithIcon(icon:NSString,title:NSString) -> UIButton{
        var button = UIButton()
        button.setImage(UIImage(named: icon), forState: UIControlState.Normal)
        button.setTitle(title, forState: UIControlState.Normal)
        button.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        button.titleLabel?.font = UIFont.systemFontOfSize(13)
        
        
        
        button.adjustsImageWhenDisabled = false
        
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
        self.addSubview(button)
        return button
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func drawRect(rect: CGRect) {
        UIImage.resizeImage("statusdetail_toolbar_background").drawInRect(rect)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let buttonNum = self.subviews.count
        let margin = 10
        let buttonW = (self.width - CGFloat(Float((buttonNum+1)*margin))) / CGFloat(Float(buttonNum))
        let buttonH = self.height - 10
        var i = 0
        for  i=0 ; i<buttonNum ; i++ {
            
            var btn = self.subviews[i] as UIButton
            btn.frame = CGRectMake(CGFloat(Float(i))*buttonW + CGFloat(Float(margin * (i+1))), 5, buttonW, buttonH)
            
        }
    }

}
