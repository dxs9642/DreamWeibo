//
//  ButtonsView.swift
//  DreamWeibo
//
//  Created by 孙龙霄 on 3/22/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

import UIKit


protocol FriendProtocol{
    func FriendAbortClick()
    func FriendAddClick()
}

class ButtonsView: UIView,UIAlertViewDelegate {


    let selfMessage:UIButton!
    let addFriend:UIButton!
    var userInfo:DreamUser?
    var buttonSelected = false
    var delegate:FriendProtocol?
    
    override init() {
        super.init()
        

        
        selfMessage = UIButton()
        selfMessage.setTitle("私信", forState: UIControlState.Normal)
        selfMessage.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        selfMessage.titleLabel?.font = UIFont.systemFontOfSize(12)
        self.addSubview(selfMessage)
        
        addFriend = UIButton()
        addFriend.setTitle("关注", forState: UIControlState.Normal)
        addFriend.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        addFriend.titleLabel?.font = UIFont.systemFontOfSize(12)
        addFriend.addTarget(self, action: "addOrRemoveFriend", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(addFriend)
        
        
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupIsFollowing(following:Bool){
        
        if following {
            
            addFriend.backgroundColor = UIColor.orangeColor()
            addFriend.setTitle("已关注", forState: UIControlState.Normal)
            addFriend.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            buttonSelected = true
            
            
        }else{
            
            addFriend.backgroundColor = UIColor.whiteColor()
            addFriend.setTitle("关注", forState: UIControlState.Normal)
            addFriend.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
            buttonSelected = false
            
        }
        
        
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        selfMessage.height = 25
        selfMessage.width = 80
        selfMessage.x = (self.frame.width - 2 * selfMessage.width - 10) / 2
        selfMessage.y = 0
        
        selfMessage.layer.masksToBounds = true
        selfMessage.layer.cornerRadius = 3
        selfMessage.layer.borderWidth = 0.5
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colorref = CGColorCreate(colorSpace, [1,44/256,44/256,44/256])
        selfMessage.layer.borderColor = colorref
        
        addFriend.height = selfMessage.height
        addFriend.width = selfMessage.width
        addFriend.x = CGRectGetMaxX(selfMessage.frame) + 10
        addFriend.y = 0
        
        
        addFriend.layer.masksToBounds = true
        addFriend.layer.cornerRadius = 3
        addFriend.layer.borderWidth = 0.5
        addFriend.layer.borderColor = colorref
        
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        
        if buttonIndex == 1 {
            if buttonSelected {
                
                delegate?.FriendAbortClick()
                
            }else{
                delegate?.FriendAddClick()
            }
        }
        
        
    }
    
    
    func addOrRemoveFriend(){
        
        if buttonSelected {
     
            let alertView = UIAlertView(title: "取消关注", message: "是否取消关注此用户", delegate: self, cancelButtonTitle: "Cancel", otherButtonTitles: "确定")
            alertView.show()
            
            
        }else{
            
            let alertView = UIAlertView(title: "关注", message: "是否关注此用户", delegate: self, cancelButtonTitle: "Cancel", otherButtonTitles: "确定")
            alertView.show()
            
        }
    }

}
