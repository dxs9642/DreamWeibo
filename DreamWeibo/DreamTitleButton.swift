//
//  DreamTitleButton.swift
//  DreamWeibo
//
//  Created by 孙龙霄 on 1/16/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

import UIKit

class DreamTitleButton: UIButton {
    
    override init() {
        super.init()
        self.imageView?.contentMode = UIViewContentMode.Center
        self.titleLabel?.textAlignment = NSTextAlignment.Right
        self.titleLabel?.font = UIFont.systemFontOfSize(20)
        self.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        self.adjustsImageWhenHighlighted = false
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func imageRectForContentRect(contentRect: CGRect) -> CGRect {
        return CGRectMake(self.width()-self.height(), 0, self.height(), self.height())
    }
    
    override func titleRectForContentRect(contentRect: CGRect) -> CGRect {
        return CGRectMake(0, 0, self.width()-self.height(), self.height())
    }
    
    
}
