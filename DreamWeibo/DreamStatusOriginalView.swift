//
//  DreamStatusOriginalView.swift
//  DreamWeibo
//
//  Created by 孙龙霄 on 1/20/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

import UIKit

class DreamStatusOriginalView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

    var iconView:UIImageView?
    var nameLabel:UILabel?
    var textLabel:UILabel?
    var sourceLabel:UILabel?
    var timeLabel:UILabel?
    var vipView:UIImageView?
    var photosView:DreamStatusPhotosView?
    var originalFrame:DreamStatusOriginalFrame?
    
    override init(){
        super.init()
        
        let font = DreamFont()
        
        
        nameLabel = UILabel()
        nameLabel?.font = font.DreamStatusOrginalNameFont
        
        
        self.addSubview(nameLabel!)
        
        
        textLabel = UILabel()
        textLabel?.font = font.DreamStatusOrginalTextFont
        textLabel?.numberOfLines = 0
        
        
        self.addSubview(textLabel!)
        
        sourceLabel = UILabel()
        sourceLabel?.font = font.DreamStatusOrginalSourceFont
        sourceLabel?.textColor = UIColor.lightGrayColor()
        
        
        self.addSubview(sourceLabel!)
        
        
        
        timeLabel = UILabel()
        timeLabel?.font = font.DreamStatusOrginalTimeFont
        timeLabel?.textColor = UIColor.orangeColor()
        
        
        
        self.addSubview(timeLabel!)
        
        
        iconView = UIImageView()
    
        
        
        self.addSubview(iconView!)
        
        vipView = UIImageView()
        vipView?.contentMode = UIViewContentMode.Center
        self.addSubview(vipView!)
        
        photosView = DreamStatusPhotosView()
        
        self.addSubview(photosView!)
        
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupOriginalFrame(originalFrame:DreamStatusOriginalFrame){
        self.originalFrame = originalFrame

        self.frame = originalFrame.frame
        
        let status = originalFrame.status
        let user = status.user
        
        self.originalFrame = originalFrame
        
        
        self.iconView?.frame = originalFrame.iconFrame
        self.iconView?.setImageWithURL(NSURL(string: user.profile_image_url!), placeholderImage: UIImage(named: "avatar_default_small"))
        
        self.nameLabel?.frame = originalFrame.nameFrame
        self.nameLabel?.text = user.name
        if user.vip==true {
            self.nameLabel?.textColor = UIColor.orangeColor()
            self.vipView?.hidden = false
            self.vipView?.frame = originalFrame.vipFrame
            self.vipView?.image = UIImage(named: "common_icon_membership_level\(user.mbrank)")
        }else{
            self.vipView?.hidden = true
        }
        
        
        self.textLabel?.frame = originalFrame.textFrame
        self.textLabel?.text = status.text
        
        
        let time = status.created_at as NSString
        let timeX = CGRectGetMinX(self.nameLabel!.frame)
        let timeY = CGRectGetMaxY(self.nameLabel!.frame) + 5
        var dic = NSMutableDictionary()
        let font = DreamFont()
        dic[NSFontAttributeName] = font.DreamStatusOrginalTimeFont
        let timeSize = time.sizeWithAttributes(dic)
        self.timeLabel?.frame = CGRectMake(timeX, timeY, timeSize.width, timeSize.height)
        self.timeLabel?.text = time
        
        let source = status.source
        let sourceX = CGRectGetMaxX(self.timeLabel!.frame) + 10
        let sourceY = timeY
        dic[NSFontAttributeName] = font.DreamStatusOrginalSourceFont
        let sourceSize = source.sizeWithAttributes(dic)
        self.sourceLabel?.frame = CGRectMake(sourceX, sourceY, sourceSize.width, sourceSize.height)
        self.sourceLabel?.text = source
        
        if status.pic_urls!.count == 0 {
            self.photosView?.hidden = true
        }else{
            self.photosView?.hidden = false
            self.photosView?.frame = originalFrame.photosFrame
            self.photosView?.setupPic_urls(status.pic_urls)
        }
        
    }
}
