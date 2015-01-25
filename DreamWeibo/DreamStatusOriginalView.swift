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
        
        
        
        self.addSubview(sourceLabel!)
        
        
        
        timeLabel = UILabel()
        timeLabel?.font = font.DreamStatusOrginalTimeFont
        
        
        
        
        self.addSubview(timeLabel!)
        
        
        iconView = UIImageView()
    
        
        
        self.addSubview(iconView!)
        
        
        
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
        
        self.textLabel?.frame = originalFrame.textFrame
        self.textLabel?.text = status.text
        
        self.sourceLabel?.frame = originalFrame.sourceFrame
        self.sourceLabel?.text = status.source
        
        self.timeLabel?.frame = originalFrame.timeFrame
        self.timeLabel?.text = status.created_at
    }
}
