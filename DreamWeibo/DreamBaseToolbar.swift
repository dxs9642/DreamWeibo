//
//  DreamBaseToolbar.swift
//  DreamWeibo
//
//  Created by 孙龙霄 on 1/30/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

import UIKit

class DreamBaseToolbar: UIImageView {

    var buttons = NSMutableArray()
    var repostButton:UIButton?
    var commentButton:UIButton?
    var attitudesButton:UIButton?
    var firstTime = true
    
    var status:DreamStatus!{
        didSet{
            
            if !firstTime {return}
            let reposts_count = Int(status.reposts_count)
            setupBtnTitle(repostButton!, count: reposts_count, defaultTitle: "转发")
            let comment_count = Int(status.comments_count)
            setupBtnTitle(commentButton!, count: comment_count, defaultTitle: "评论")
            
            let attitudes_count = Int(status.attitudes_count)
            setupBtnTitle(attitudesButton!, count: attitudes_count, defaultTitle: "赞")
            firstTime = false
        }
    }
    
    override init() {
        super.init()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.userInteractionEnabled = true
        
        self.repostButton = setupButtonWithIcon("timeline_icon_retweet", title: "转发")
        self.commentButton = setupButtonWithIcon("timeline_icon_comment", title: "评论")
        self.attitudesButton = setupButtonWithIcon("timeline_icon_unlike", title: "赞")
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func setupBtnTitle(button:UIButton,count:Int,defaultTitle:NSString){
        var title = ""
        
        if count == 0 {
            title = defaultTitle
        }else if count>10000 {
            if count / 1000 % 10 == 0 {
                title = "\(count / 10000)万"
            }else{
                title = "\(count / 10000).\(count / 1000 % 10)万"
            }
            
        }else{
            title = "\(count)"
        }

        button.setTitle(title, forState: UIControlState.Normal)
        

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
    }


    

}
