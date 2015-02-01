//
//  DreamStatusRetweetView.swift
//  DreamWeibo
//
//  Created by 孙龙霄 on 1/20/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

import UIKit

class DreamStatusRetweetView: UIImageView {

    var textLabel:DreamStatusLabel?
    var photosView:DreamStatusPhotosView?
    var reweetFrame:DreamStatusRetweetedFrame?
    var toolbar:DreamBaseToolbar?
    
    override init(){
        super.init()
        
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.userInteractionEnabled = true
        
        

        self.image = UIImage.resizeImage("timeline_retweet_background")
        self.highlightedImage = UIImage.resizeImage("timeline_retweet_background_highlighted")
        
        
        textLabel = DreamStatusLabel()
        self.addSubview(textLabel!)
        
        photosView = DreamStatusPhotosView()
        
        self.addSubview(photosView!)
        
        toolbar = DreamStatusRetweetedToolbar()
        self.addSubview(toolbar!)
        
        

    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupEmptyRetweetFrame(){
        self.frame = CGRectMake(0, 0, 0, 0)
        self.hidden = true

    }
    
    func setupReweetFrame(reweetFrame:DreamStatusRetweetedFrame){
        self.reweetFrame = reweetFrame
        self.hidden = false
        self.frame = reweetFrame.frame
        
        let status = reweetFrame.retweetedStatus
        let user = status.user

        
        self.textLabel?.frame = reweetFrame.textFrame
        self.textLabel?.attributedText = status.attributedText


        if status.pic_urls!.count == 0 {
            self.photosView?.hidden = true
        }else{
            self.photosView?.hidden = false
            self.photosView?.frame = reweetFrame.photosFrame
            self.photosView?.setupPic_urls(status.pic_urls)
        }
        if status.detail {
            self.toolbar?.frame = reweetFrame.toolbarFrame
            self.toolbar?.status = reweetFrame.retweetedStatus
            self.toolbar?.hidden = false
        }else{
            self.toolbar?.hidden = true

        }
    }
    
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
    }
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        
    }
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        let tabbarVc = UIApplication.sharedApplication().keyWindow?.rootViewController as UITabBarController
        let nav = tabbarVc.selectedViewController as UINavigationController
        let detailVc = DreamStatusDetailViewController()
        detailVc.status = self.reweetFrame?.retweetedStatus

        
        nav.pushViewController(detailVc, animated: true)
        
    }
    override func touchesCancelled(touches: NSSet!, withEvent event: UIEvent!) {
        
    }

    
    
}
