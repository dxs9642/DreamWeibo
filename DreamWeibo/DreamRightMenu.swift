//
//  DreamRightMenu.swift
//  DreamWeibo
//
//  Created by 孙龙霄 on 2/3/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

import UIKit

class DreamRightMenu: UIView {


    var profile:UIImageView!
    var userInfo:UIButton!
    var timer:NSTimer!
    var userImage:UIImage!
    
    
    override init() {
        super.init()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTopView()


        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTopView(){
        
        let account = Account.getAccount()
        if account == nil {
            Account.expiredAndReAuth()
        }
        
        profile = UIImageView(image: UIImage(named: "default_avatar"))
        self.addSubview(profile)
        
        userInfo = UIButton()
        userInfo.setTitle(Account.getName(), forState: UIControlState.Normal)
        userInfo.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        userInfo.titleLabel?.font = UIFont.systemFontOfSize(17)
        userInfo.titleLabel?.textAlignment = NSTextAlignment.Center
        self.addSubview(userInfo)
        
        getUserImage()
        

        
        
    }
    
    func getUserImage(){
        let account = Account.getAccount()
        if account == nil {
            Account.expiredAndReAuth()
        }

        
        let image = account?.getUserImage()
        if image != nil {
            self.userImage = image
        }
        
    }
    
    override func layoutSubviews() {
    
        profile.x = ( 200 - profile.width ) / 2 + 75
        userInfo.center.x = profile.center.x
        userInfo.y = profile.height + 20
        let count = (userInfo.titleLabel!.text! as NSString).length
        let length = count*20 + 30
        userInfo.setWidth(CGFloat(Float(length)))
        userInfo.height = 30

    
    }
    
    func didShow(){

        getUserImage()
        let anim = CATransition()
        anim.duration = 1
        anim.type = "rippleEffect"
        self.profile.layer.addAnimation(anim, forKey: nil)
        self.profile.image = self.userImage
        

    }

}
