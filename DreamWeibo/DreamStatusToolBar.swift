 //
//  DreamStatusToolBar.swift
//  DreamWeibo
//
//  Created by 孙龙霄 on 1/20/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

import UIKit

class DreamStatusToolBar: UIImageView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    var buttons = NSMutableArray()
    var dividers = NSMutableArray()
    
    
    override init() {
        super.init()
        self.userInteractionEnabled = true
        self.image = UIImage.resizeImage("timeline_card_bottom_background")
  

        setupButtonWithIcon("timeline_icon_retweet", title: "转发")
        
        setupButtonWithIcon("timeline_icon_comment", title: "评论")
        setupButtonWithIcon("timeline_icon_unlike", title: "赞")
        
        setupDivider()
        setupDivider()
        
        
        
    }
    
    func setupDivider(){
        var divider = UIImageView()
        divider.image = UIImage(named: "timeline_card_bottom_line")
        divider.highlightedImage = UIImage(named: "timeline_card_bottom_line_highlighted")
        divider.contentMode = UIViewContentMode.Center
        self.addSubview(divider)
        
        self.dividers.addObject(divider)
    }
    
    
    func setupButtonWithIcon(icon:NSString,title:NSString){
        var button = UIButton()
        button.setImage(UIImage(named: icon), forState: UIControlState.Normal)
        button.setTitle(title, forState: UIControlState.Normal)
        button.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        button.titleLabel?.font = UIFont.systemFontOfSize(13)
        
        
        button.setBackgroundImage(UIImage.resizeImage("timeline_card_bottom_background_highlighted"), forState: UIControlState.Highlighted)
        
        button.adjustsImageWhenDisabled = false
        
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
        self.addSubview(button)
        self.buttons.addObject(button)
    }

    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let buttonNum = self.buttons.count
        let buttonW = self.width() / CGFloat(Float(buttonNum))
        let buttonH = self.height()
        var i = 0
        for  i=0 ; i<buttonNum ; i++ {
            
            var btn = self.buttons[i] as UIButton
            btn.frame = CGRectMake(CGFloat(Float(i))*buttonW, 0, buttonW, buttonH)
            
            
        }
        
        let dividerNum = self.dividers.count
        let dividerH = buttonH
        for  i=0 ; i<dividerNum ; i++ {
            var div = self.dividers[i] as UIImageView

            div.setWidth(4)
            div.setHeight(dividerH)
            div.center.x = CGFloat(Float(i+1))*buttonW
            div.center = CGPointMake( CGFloat(Float(i+1))*buttonW, buttonH*0.5)
        }
        
        
    }
    
    
}
