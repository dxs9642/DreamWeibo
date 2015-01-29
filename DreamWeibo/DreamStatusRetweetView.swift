//
//  DreamStatusRetweetView.swift
//  DreamWeibo
//
//  Created by 孙龙霄 on 1/20/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

import UIKit

class DreamStatusRetweetView: UIImageView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    
//    var nameLabel:UILabel?
    var textLabel:DreamStatusLabel?
    var photosView:DreamStatusPhotosView?
    var reweetFrame:DreamStatusRetweetedFrame?
    
    
    override init(){
        super.init()
        self.userInteractionEnabled = true
        self.image = UIImage.resizeImage("timeline_retweet_background")
        self.highlightedImage = UIImage.resizeImage("timeline_retweet_background_highlighted")
        
        
        
        let font = DreamFont()
        
//        nameLabel = UILabel()
//        nameLabel?.font = font.DreamStatusRetweetedNameFont
//        
//        
//        self.addSubview(nameLabel!)
        
        
        textLabel = DreamStatusLabel()
        self.addSubview(textLabel!)
        
        photosView = DreamStatusPhotosView()
        
        self.addSubview(photosView!)
        
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupReweetFrame(reweetFrame:DreamStatusRetweetedFrame){
        self.reweetFrame = reweetFrame
        
        self.frame = reweetFrame.frame
        
        let status = reweetFrame.retweetedStatus
        let user = status.user

        self.reweetFrame = reweetFrame
//        self.nameLabel?.frame = reweetFrame.nameFrame
//        self.nameLabel?.text = "@\(user.name)"
//        self.nameLabel?.textColor = UIColor(red: 74/255, green: 102/255, blue: 105/255, alpha: 1)
        
        self.textLabel?.frame = reweetFrame.textFrame
        self.textLabel?.attributedText = status.attributedText

        if status.pic_urls!.count == 0 {
            self.photosView?.hidden = true
        }else{
            self.photosView?.hidden = false
            self.photosView?.frame = reweetFrame.photosFrame
            self.photosView?.setupPic_urls(status.pic_urls)
        }
        
    }

//    override func drawRect(rect: CGRect) {
//        UIImage.resizeImage("timeline_retweet_background").drawInRect(rect)
//    }
    

    
    
}
