 //
//  DreamStatusToolBar.swift
//  DreamWeibo
//
//  Created by 孙龙霄 on 1/20/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

import UIKit

class DreamStatusToolBar: DreamBaseToolbar {

    var dividers = NSMutableArray()

    override init() {
        super.init()
        
        self.image = UIImage.resizeImage("timeline_card_bottom_background")
        
        setupDivider()
        setupDivider()
        
    }
    
    func setupDivider(){
        var divider = UIImageView()
        divider.image = UIImage(named: "timeline_card_bottom_line")
        divider.highlightedImage = UIImage(named: "timeline_card_bottom_line_highlighted")
        divider.contentMode = UIViewContentMode.Center
        self.addSubview(divider)
        
        self.dividers.addObject(divider)
    }
    
    
  
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let buttonNum = self.buttons.count
        let buttonW = self.width() / CGFloat(Float(buttonNum))
        let buttonH = self.height()
        
        let dividerNum = self.dividers.count
        let dividerH = buttonH
        for  var i=0 ; i<dividerNum ; i++ {
            var div = self.dividers[i] as UIImageView

            div.setWidth(4)
            div.setHeight(dividerH)
            div.center.x = CGFloat(Float(i+1))*buttonW
            div.center = CGPointMake( CGFloat(Float(i+1))*buttonW, buttonH*0.5)
        }
        
        
    }
    
    
}
