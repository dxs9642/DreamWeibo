//
//  DreamEmotionKeyboard.swift
//  DreamWeibo
//
//  Created by 孙龙霄 on 1/26/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

import UIKit

class DreamEmotionKeyboard: UIView {

    var listView:DreamEmotionListView?
    var toolbar:UIView?
    var selectedButton:UIButton?
    
    
    override init() {
        super.init()

    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        listView = DreamEmotionListView()
        self.backgroundColor = UIColor.blueColor()
        self.addSubview(listView!)
        
        toolbar = UIView()
        toolbar?.backgroundColor = UIColor.purpleColor()
        self.addSubview(toolbar!)
        
        setupToolbarButton("最近", tag: 1)
        setupToolbarButton("默认", tag: 2)
        setupToolbarButton("Emoji", tag: 3)
        setupToolbarButton("浪小花", tag: 4)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.toolbar?.frame = CGRectMake(0, self.height()-35, self.width(), 35)
        
        self.listView?.frame = CGRectMake(0, 0, self.width(), self.height()-35)
        
        let buttonW  = self.toolbar!.width() / 4
        for var i=0;i<4;i++ {
            var button = self.toolbar?.subviews[i] as UIButton
            button.frame = CGRectMake(CGFloat(Float(i))*buttonW, 0, buttonW, self.toolbar!.height())
            
        }
        
    }
    
    


    func setupToolbarButton(title:NSString,tag:Int){
        
        var button = UIButton()
        
        button.setTitle(title, forState: UIControlState.Normal)
        button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        button.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Selected)
        button.titleLabel?.font = UIFont.systemFontOfSize(13)
        button.addTarget(self, action: "toolbarButtonClick:", forControlEvents: UIControlEvents.TouchUpInside)
        self.toolbar?.addSubview(button)

        
        if tag == 1 {
            
            button.setBackgroundImage(UIImage.resizeImage("compose_emotion_table_left_normal"), forState: UIControlState.Normal)
            button.setBackgroundImage(UIImage.resizeImage("compose_emotion_table_left_selected"), forState: UIControlState.Selected)
            
        }else if tag == 4 {
            
            button.setBackgroundImage(UIImage.resizeImage("compose_emotion_table_right_normal"), forState: UIControlState.Normal)
            button.setBackgroundImage(UIImage.resizeImage("compose_emotion_table_right_selected"), forState: UIControlState.Selected)
        }else{
            
            button.setBackgroundImage(UIImage.resizeImage("compose_emotion_table_mid_normal"), forState: UIControlState.Normal)
            button.setBackgroundImage(UIImage.resizeImage("compose_emotion_table_mid_selected"), forState: UIControlState.Selected)
        }
        
        if tag == 2{
            toolbarButtonClick(button)
        }
    }
    
    func toolbarButtonClick(button:UIButton){
        
        selectedButton?.selected = false
        
        button.selected = true
        selectedButton = button
        
    }
    
}
