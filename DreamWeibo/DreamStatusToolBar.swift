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
    var repostButton:UIButton?
    var commentButton:UIButton?
    var attitudesButton:UIButton?

    override init() {
        super.init()
        self.userInteractionEnabled = true
        self.image = UIImage.resizeImage("timeline_card_bottom_background")
  

        self.repostButton = setupButtonWithIcon("timeline_icon_retweet", title: "转发")
        
        self.commentButton = setupButtonWithIcon("timeline_icon_comment", title: "评论")
        self.attitudesButton = setupButtonWithIcon("timeline_icon_unlike", title: "赞")
        
        setupDivider()
        setupDivider()
        
    }
    
    
    func setupStatus(status:DreamStatus){
        
        
        var repostTitleCount = ""
        let reposts_count = Int(status.reposts_count)
        if reposts_count>10000 {
            if reposts_count / 1000 % 10 == 0 {
                repostTitleCount = "\(reposts_count / 10000)万"
            }else{
                repostTitleCount = "\(reposts_count / 10000).\(reposts_count / 1000 % 10)万"
            }
            
        }else{
            repostTitleCount = "\(reposts_count)"
        }
        let repostTitle = reposts_count == 0 ? "转发" : repostTitleCount
        self.repostButton!.setTitle(repostTitle, forState: UIControlState.Normal)
        
        
        
        var commentTitleCount = ""
        let comment_count = Int(status.comments_count)
        if comment_count>10000 {
            if comment_count / 1000 % 10 == 0 {
                commentTitleCount = "\(comment_count / 10000)万"
            }else{
                commentTitleCount = "\(comment_count / 10000).\(comment_count / 1000 % 10)万"
            }
            
        }else{
            commentTitleCount = "\(comment_count)"
        }
        let commentTitle = comment_count == 0 ? "评论" : commentTitleCount
        self.commentButton!.setTitle(commentTitle, forState: UIControlState.Normal)
        
        var attitudesTitleCount = ""
        let attitudes_count = Int(status.attitudes_count)
        if attitudes_count>10000 {
            if attitudes_count / 1000 % 10 == 0 {
                attitudesTitleCount = "\(attitudes_count / 10000)万"
            }else{
                attitudesTitleCount = "\(attitudes_count / 10000).\(attitudes_count / 1000 % 10)万"
            }
            
        }else{
            attitudesTitleCount = "\(attitudes_count)"
        }
        let attitudesTitle = Int(status.attitudes_count) == 0 ? "赞" : attitudesTitleCount
        self.attitudesButton!.setTitle(attitudesTitle, forState: UIControlState.Normal)
    }
    
    func setupDivider(){
        var divider = UIImageView()
        divider.image = UIImage(named: "timeline_card_bottom_line")
        divider.highlightedImage = UIImage(named: "timeline_card_bottom_line_highlighted")
        divider.contentMode = UIViewContentMode.Center
        self.addSubview(divider)
        
        self.dividers.addObject(divider)
    }
    
    
    func setupButtonWithIcon(icon:NSString,title:NSString) -> UIButton{
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
        return button
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
