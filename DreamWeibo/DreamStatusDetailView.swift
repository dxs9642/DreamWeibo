//
//  DreamStatusDetailView.swift
//  DreamWeibo
//
//  Created by 孙龙霄 on 1/20/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

import UIKit

class DreamStatusDetailView: UIView {

    
    var detailFrame:DreamStatusDetailFrame?
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    var originalView:DreamStatusOriginalView?
    var retweetView:DreamStatusRetweetView?
    
    override init(){
        super.init()
        
        
        setupOriginalView()
        setupRetweetView()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupOriginalView(){
        
        var originalView = DreamStatusOriginalView()
        self.originalView = originalView
        
        
        
        self.addSubview(originalView)
        
    }
    
    func setupRetweetView(){
        
        var retweetView = DreamStatusRetweetView()
        self.retweetView = retweetView
        
        
        
        
        
        self.addSubview(retweetView)
        
    }
    
    func setupDetailFrame(detailFrame:DreamStatusDetailFrame){
        
        self.detailFrame = detailFrame
        
        self.frame = detailFrame.frame
        
        self.originalView?.setupOriginalFrame(detailFrame.originalFrame)
        if detailFrame.retweetedFrame != nil {
            self.retweetView?.setupReweetFrame(detailFrame.retweetedFrame)
        
        }
    }


}
