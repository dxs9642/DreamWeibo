//
//  UIBarButtonItem+Extension.swift
//  DreamWeibo
//
//  Created by 孙龙霄 on 1/15/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
    
    class func initBarButtonItem(image:NSString,imageHighlight:NSString,target:UIViewController,action:NSString) -> UIBarButtonItem{
        var button = UIButton()
        button.setBackgroundImage(UIImage(named: image), forState: UIControlState.Normal)
        button.setBackgroundImage(UIImage(named: imageHighlight), forState: UIControlState.Highlighted)
        let size = button.currentBackgroundImage!.size
        button.frame = CGRectMake(0, 0, size.width, size.height)
        button.addTarget(target, action: Selector(action), forControlEvents: UIControlEvents.TouchUpInside)
        
        return UIBarButtonItem(customView: button)
    }
    
}
