//
//  DreamPopMenu.swift
//  DreamWeibo
//
//  Created by 孙龙霄 on 1/16/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

import UIKit

enum DreamMenuArrorPosition:Int{
    case HMPopMenuArrowPositionCenter = 0
    case HMPopMenuArrowPositionLeft = 1
    case HMPopMenuArrowPositionRight = 2
}

protocol DreamMenuProtocol{
    func popMenuDidDismissed(popMenu:DreamPopMenu)
}

class DreamPopMenu: UIView {

    
    var delegate:DreamMenuProtocol?
    var contentView:UIView?
    var cover:UIButton?
    var container:UIImageView?
    var dimBackground = false
    var arrowPosition:DreamMenuArrorPosition?
    
    override init() {
        super.init()
        var cover = UIButton()
        cover.backgroundColor = UIColor.clearColor()
        cover.addTarget(self, action: "coverClick", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(cover)
        self.cover = cover
        
        var container = UIImageView()
        container.userInteractionEnabled = true
        container.image = UIImage.resizeImage("popover_background")
        self.addSubview(container)
        self.container = container
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initPopMenu(contentView:UIView) -> DreamPopMenu {
        self.contentView = contentView
        return self
    }
    
    class func initWithContentView(contentView:UIView) -> DreamPopMenu {
        return DreamPopMenu().initPopMenu(contentView)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.cover?.frame = self.bounds
        
    }
    
    
    
    
    func coverClick(){
        self.delegate?.popMenuDidDismissed(self)
        self.removeFromSuperview()
    }
    
    func setBackground(image:UIImage){
        self.container?.image = image
    }
    
    func setDimBackground(dimBackground:Bool){
        self.dimBackground = dimBackground
        if dimBackground {
            self.cover?.backgroundColor = UIColor.blackColor()
            self.cover?.alpha = 0.3
        }else{
            self.cover?.backgroundColor = UIColor.clearColor()
            self.cover?.alpha = 1.0
        }
    }
    
    func setArrowPosition(arrowPosition:DreamMenuArrorPosition){
        self.arrowPosition = arrowPosition
        switch(arrowPosition){
        case DreamMenuArrorPosition.HMPopMenuArrowPositionCenter:
            self.container?.image = UIImage.resizeImage("popover_background")
        case DreamMenuArrorPosition.HMPopMenuArrowPositionLeft:
            self.container?.image = UIImage.resizeImage("popover_background_left")
        case DreamMenuArrorPosition.HMPopMenuArrowPositionRight:
            self.container?.image = UIImage.resizeImage("popover_background_right")
        }
    }
    
    func showInRect(rect:CGRect){
        var window = UIApplication.sharedApplication().keyWindow
        self.frame = window!.bounds
        window?.addSubview(self)
        
        self.container?.frame = rect
        
        let topMargin:CGFloat = 12;
        let leftMargin:CGFloat = 5;
        let rightMargin:CGFloat = 5;
        let bottomMargin:CGFloat = 8;
        
        self.contentView?.frame = CGRectMake(leftMargin, topMargin, self.container!.width() - leftMargin - rightMargin, container!.height() - topMargin - bottomMargin)
        
        self.container?.addSubview(self.contentView!)
        

        
    }
    
    
    
}
