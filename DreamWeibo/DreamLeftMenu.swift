//
//  DreamLeftMenu.swift
//  DreamWeibo
//
//  Created by 孙龙霄 on 2/2/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

import UIKit

class DreamLeftMenu: UIView,UITabBarDelegate {


    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.userInteractionEnabled = true
        
        setupButtonWithIcon("tabbar_home_os7", title: "首页",tag: 800)
        setupButtonWithIcon("tabbar_message_center_os7", title: "消息",tag: 801)
        setupButtonWithIcon("tabbar_discover_os7", title: "发现",tag: 802)
        setupButtonWithIcon("tabbar_profile_os7", title: "我",tag: 803)

    }

    func setupButtonWithIcon(icon:NSString,title:NSString,tag:NSInteger) -> UIButton{
        var button = UIButton()
        button.tag = tag
        button.setTitle(title as String, forState: UIControlState.Normal)
        button.setImage(UIImage(named: icon as String), forState: UIControlState.Normal)
        button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        button.titleLabel?.font = UIFont.systemFontOfSize(13)
        
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)

        button.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        button.contentEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 0)
        let bgimage = UIImage.createImageWithColor(UIColor(white: 1, alpha: 0.66))

        bgimage.stretchableImageWithLeftCapWidth(Int(Float(bgimage.size.width*0.5)) , topCapHeight:Int(Float(bgimage.size.height*0.5)))
        button.setBackgroundImage(bgimage, forState: UIControlState.Highlighted)
    
        button.addTarget(self, action: "itemClick:", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.addSubview(button)
        return button
    }
    
    func itemClick(button:UIButton){
        let mainVc = UIApplication.sharedApplication().keyWindow?.rootViewController as! MainViewController
        let tabbarVc = mainVc.initViewController as WeiboTabBarViewController
        
        switch button.tag {
        case 800:
            tabbarVc.selectedViewController = tabbarVc.childViewControllers[0] as! UINavigationController
        case 801:
             tabbarVc.selectedViewController = tabbarVc.childViewControllers[1] as! UINavigationController
        case 802:
             tabbarVc.selectedViewController = tabbarVc.childViewControllers[2] as! UINavigationController
        case 803:
             tabbarVc.selectedViewController = tabbarVc.childViewControllers[3] as! UINavigationController
        default:
            break
        }
        
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            
            if  CGAffineTransformIsIdentity(tabbarVc.view.transform) {
                let firstTrans = CGAffineTransformMakeScale(0.75, 0.75)
                tabbarVc.view.transform = CGAffineTransformTranslate(firstTrans, 200, 0)
            }else{
                tabbarVc.view.transform = CGAffineTransformIdentity
            }
            
        })

    }
    

    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem!) {
        println("select")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let buttonNum = self.subviews.count
        let buttonW = self.width
        let buttonH = self.height / CGFloat(Float(buttonNum))
        var i = 0
        for  i=0 ; i<buttonNum ; i++ {
            
            var btn = self.subviews[i] as! UIButton
            btn.frame = CGRectMake(0, buttonH*CGFloat(Float(i)), buttonW, buttonH)
            
        }

    }
    



}
