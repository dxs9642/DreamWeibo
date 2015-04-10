//
//  DreamStatusDetailBottonToolbar.swift
//  DreamWeibo
//
//  Created by 孙龙霄 on 1/30/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

import UIKit

protocol DreamTopToolbarButtonProtocol{
    func TopToolbarButtonClick(button:UIButton)
}


class DreamStatusDetailTopToolbar: UIView {
    
    var selectedButton:UIButton!
    var firstTime = true
    var delegate:DreamTopToolbarButtonProtocol?
    var status:DreamStatus!{
        didSet{
            
            let reposts_count = Int(status.reposts_count)
            setupBtnTitle(repost!, count: reposts_count, defaultTitle: "转发")
            let comment_count = Int(status.comments_count)
            setupBtnTitle(comment!, count: comment_count, defaultTitle: "评论")
            let attitudes_count = Int(status.attitudes_count)
            setupBtnTitle(attitudes!, count: attitudes_count, defaultTitle: "赞")

            
        }
    }

    
    
    class var toolbar:DreamStatusDetailTopToolbar!{
        
        get{
            
            return (NSBundle.mainBundle().loadNibNamed("DreamStatusDetailTopToolbar", owner: nil, options: nil) as NSArray ).lastObject as! DreamStatusDetailTopToolbar

        }
    }
    
    @IBOutlet weak var arrowLeft: UIImageView!
    
    @IBOutlet weak var arrowRight: UIImageView!
    
    @IBOutlet weak var repost: UIButton!
    @IBOutlet weak var comment: UIButton!
    @IBOutlet weak var attitudes: UIButton!
    
    
    @IBAction func buttonClick(sender: UIButton) {
        
        delegate?.TopToolbarButtonClick(sender)
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
    
    func reloadCommentData(count:NSInteger){
        setupBtnTitle(comment!, count: count, defaultTitle: "评论")
        
    }
    
    func reloadRepostData(count:NSInteger){
        setupBtnTitle(repost!, count: count, defaultTitle: "转发")
        
    }
    
    override func drawRect(rect: CGRect) {
        UIImage.resizeImage("statusdetail_comment_top_background").drawInRect(rect)
    }
    
    func setupBtnTitle(button:UIButton,count:Int,defaultTitle:NSString){
        var title = ""
        
        if count>10000 {
            if count / 1000 % 10 == 0 {
                title = "\(count / 10000)万"
            }else{
                title = "\(count / 10000).\(count / 1000 % 10)万"
            }
            
        }else{
            title = "\(count)"
        }
        
        button.setTitle((defaultTitle as String) + " " + title, forState: UIControlState.Normal)
        
        
    }
    
}
