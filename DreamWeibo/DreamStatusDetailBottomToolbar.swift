//
//  DreamStatusDetailTopToolbar.swift
//  DreamWeibo
//
//  Created by 孙龙霄 on 1/30/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

import UIKit

class DreamStatusDetailBottomToolbar: DreamBaseToolbar {


    
    convenience init() {
        
        let frame = CGRectMake(0, 0, 0, 0)
        self.init(frame:frame)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.image = UIImage.resizeImage("timeline_card_bottom_background")


    }
    
    override func setupButtonWithIcon(icon:NSString,title:NSString) -> UIButton{
        var button = UIButton()
        button.setImage(UIImage(named: icon as String), forState: UIControlState.Normal)
        button.setTitle(title as String, forState: UIControlState.Normal)
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
            
            var btn = self.subviews[i] as! UIButton
            btn.frame = CGRectMake(CGFloat(Float(i))*buttonW + CGFloat(Float(margin * (i+1))), 5, buttonW, buttonH)
            
        }
    }

}
