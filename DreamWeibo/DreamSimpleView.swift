//
//  DreamSimpleView.swift
//  DreamWeibo
//
//  Created by 孙龙霄 on 3/29/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

import UIKit

class DreamSimpleView: UIImageView {

    
    var iconView:UIImageView?
    var nameLabel:UILabel?
    var textLabel:DreamStatusLabel?
    var timeLabel:UILabel?
    var vipView:UIImageView?
    var simpleFrame:DreamSimpleFrame?
    
    override init(){
        super.init()
        self.userInteractionEnabled = true
        let font = DreamFont()
        
        self.image = UIImage.resizeImage("timeline_card_top_background")
        self.highlightedImage = UIImage.resizeImage("timeline_card_top_background_highlighted")

        
        nameLabel = UILabel()
        nameLabel?.font = font.DreamSimpleNameFont
        self.addSubview(nameLabel!)
        nameLabel?.userInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: "showUserInfo:")
        nameLabel?.addGestureRecognizer(tapGesture)
        
        
        textLabel = DreamStatusLabel()
        self.addSubview(textLabel!)
        
        
        timeLabel = UILabel()
        timeLabel?.font = font.DreamSimpleTimeFont
        timeLabel?.textColor = UIColor.orangeColor()
        
        
        
        self.addSubview(timeLabel!)
        
        iconView = UIImageView()
        
        
        
        self.addSubview(iconView!)
        vipView = UIImageView()
        vipView?.contentMode = UIViewContentMode.Center
        self.addSubview(vipView!)

        
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupSimpleFrame(simpleFrame:DreamSimpleFrame){
        self.simpleFrame = simpleFrame
        
        self.frame = simpleFrame.frame
        
        let simple = simpleFrame.simple
        let user = simple.user
        
        
        
        self.iconView?.frame = simpleFrame.iconFrame
        self.iconView?.sd_setImageWithURL(NSURL(string: user.profile_image_url!), placeholderImage: UIImage(named: "avatar_default_small"))
        
        self.nameLabel?.frame = simpleFrame.nameFrame
        self.nameLabel?.text = user.name
        if user.vip==true {
            self.nameLabel?.textColor = UIColor.orangeColor()
            self.vipView?.hidden = false
            self.vipView?.frame = simpleFrame.vipFrame
            self.vipView?.image = UIImage(named: "common_icon_membership_level\(user.mbrank)")
        }else{
            self.vipView?.hidden = true
            self.nameLabel?.textColor = UIColor.blackColor()
        }
        
        
        self.textLabel?.attributedText = simple.attributedText
        self.textLabel?.frame = simpleFrame.textFrame
        
        let time = simple.created_at as NSString
        let timeX = CGRectGetMinX(self.nameLabel!.frame)
        let timeY = CGRectGetMaxY(self.nameLabel!.frame) + 1
        var dic = NSMutableDictionary()
        let font = DreamFont()
        dic[NSFontAttributeName] = font.DreamSimpleTimeFont
        let timeSize = time.sizeWithAttributes(dic)
        self.timeLabel?.frame = CGRectMake(timeX, timeY, timeSize.width, timeSize.height)
        self.timeLabel?.text = time
        
        

        
    }
    
    
    func showUserInfo(recognizer:UITapGestureRecognizer){
        let userName = (recognizer.view as UILabel).text
        
        if userName != nil {
            
            let dic = NSMutableDictionary()
            dic["DreamLinkText"] = userName
            NSNotificationCenter.defaultCenter().postNotificationName("DreamDidSelectTitleNameNotionfication", object: nil, userInfo: dic )
            
            
        }
        
    }

}
