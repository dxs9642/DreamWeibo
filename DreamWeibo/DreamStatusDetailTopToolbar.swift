//
//  DreamStatusDetailBottonToolbar.swift
//  DreamWeibo
//
//  Created by 孙龙霄 on 1/30/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

import UIKit

class DreamStatusDetailTopToolbar: UIView {
    
    var selectedButton:UIButton!
    var firstTime = true
    class var toolbar:UIView!{
        get{
            return (NSBundle.mainBundle().loadNibNamed("DreamStatusDetailTopToolbar", owner: nil, options: nil) as NSArray ).lastObject as DreamStatusDetailTopToolbar

        }
    }
    
    @IBOutlet weak var arrowLeft: UIImageView!
    
    @IBOutlet weak var arrowRight: UIImageView!
    
    @IBOutlet weak var repost: UIButton!
    
    
    @IBAction func buttonClick(sender: UIButton) {
        if firstTime {
            selectedButton = repost
        }
        firstTime = false

        if sender.tag == 700 {
            arrowLeft.hidden = false
            arrowRight.hidden = true
        }else if sender.tag == 701 {
            arrowLeft.hidden = true
            arrowRight.hidden = false
        }else{
            sender.selected = true
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64( 0.2 * Float(NSEC_PER_SEC) )) , dispatch_get_main_queue()) { () -> Void in
                sender.selected = false
            }
            return
        }
        
        selectedButton.selected = false
        
        
        sender.selected = true
        selectedButton = sender

        
    }
    
    override func drawRect(rect: CGRect) {
        UIImage.resizeImage("statusdetail_comment_top_background").drawInRect(rect)
    }
    
}
