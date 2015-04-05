//
//  MessageSimpleView.swift
//  DreamWeibo
//
//  Created by 孙龙霄 on 4/2/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

import UIKit

class MessageSimpleView: UIImageView {

    
    var userImage:UIImageView!
    var userTitle:UILabel!
    var detailInfo:UILabel?
    var type = -1
    
    convenience init(type:NSInteger){
        self.init()
        self.type = type
        self.userInteractionEnabled = true

        setupUserImage(type)
        setupUserTitle(type)
            
    }
        
    
    override init(){
        super.init()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func setupUserImage(type:NSInteger){
        userImage = UIImageView()
        self.addSubview(userImage)
        
        switch(type){
        case 0:
            userImage.image =  UIImage(named: "messagescenter_at")
            break;
        case 1:
            userImage.image =  UIImage(named: "messagescenter_comments")
            break;
        case 2:
            userImage.image =  UIImage(named: "messagescenter_good")
            break;
        default:
            setupImageFromURL()
            
        }
    }
    
    func setupImageFromURL(){

    }
    
    func setupUserTitle(type:NSInteger){
        
        userTitle = UILabel()
        self.addSubview(userTitle)
        
        switch(type){
        case 0:
            userTitle.text = "@我的"
            break;
        case 1:
            userTitle.text = "评论"
            break;
        case 2:
            userTitle.text = "赞"
            break;
        default:
            setupTitleFromURL()
        }
        
    }
    
    func setupTitleFromURL(){
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.width = self.superview!.width
        self.height = self.superview!.height
        
        userImage.x = 5
        userImage.y = 10
        userImage.width = 50
        userImage.height = 50
        userImage.contentMode = UIViewContentMode.ScaleAspectFit
        userImage.clipsToBounds = true
        
        
        
        
        let font = DreamFont()
        if detailInfo != nil {
            
        }else{
            if userTitle.text == nil {
                return
            }
            userTitle.font = font.DreamStatusOrginalNameFont
            let boundingSize = CGSizeMake(self.frame.size.width, CGFloat.max)
            var attr = NSMutableDictionary()
            attr[NSFontAttributeName] = font.DreamStatusOrginalNameFont

            let theName:NSString = userTitle.text!
            let nameSize = theName.boundingRectWithSize(boundingSize, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: attr, context: nil)
            userTitle.size = nameSize.size
            userTitle.x = CGRectGetMaxX(userImage.frame) + 10
            userTitle.centerY = userImage.centerY
            
        }
        
    }

}
