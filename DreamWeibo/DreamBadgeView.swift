//
//  DreamBadgeView.swift
//  DreamWeibo
//
//  Created by 孙龙霄 on 1/30/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

import UIKit

class DreamBadgeView: UIButton {

    var badgeValue:String!{
        didSet{
            self.setTitle(badgeValue, forState: UIControlState.Normal)
            var attr = NSMutableDictionary()
            attr[NSFontAttributeName] = self.titleLabel?.font
            
            let titleSize = badgeValue.sizeWithAttributes(attr as [NSObject : AnyObject])
            let bgw = self.currentBackgroundImage!.size.width
            if titleSize.width < bgw {
                self.width = bgw
            }else{
                self.width = titleSize.width + 10
            }
            
        }
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.titleLabel?.font = UIFont.systemFontOfSize(11)
        
        self.setBackgroundImage(UIImage.resizeImage("main_badge"), forState: UIControlState.Normal)
        self.height = self.currentBackgroundImage!.size.height
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
