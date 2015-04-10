//
//  DreamEmotionKeyboard.swift
//  DreamWeibo
//
//  Created by 孙龙霄 on 1/26/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

import UIKit



class DreamEmotionKeyboard: UIView ,DreamEmotionToolbarProtocol{

    var listView:DreamEmotionListView?
    var toolbar:DreamEmotionToolbar?
    let tool = DreamEmotionTool()

    
    


    override init(frame: CGRect) {
        super.init(frame: frame)
        listView = DreamEmotionListView()
        self.addSubview(listView!)
        
        toolbar = DreamEmotionToolbar()
        toolbar?.delegate = self
        self.addSubview(toolbar!)
        
        
        tool.setDefaultEmotions()
        tool.setEmojiEmotions()
        tool.setLxhEmotions()
        toolbar?.selectDefaultButton()

    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func layoutSubviews() {
        super.layoutSubviews()
        self.listView?.frame = CGRectMake(0, 0, self.width, self.height-35)
    }

    
    func toolbarItemClick(button:UIButton){
        let type = DreamEmotionToolbarButtonType()
        switch(button.tag){
            
        case type.Recently:
            listView?.setEmotions(tool.getRecentEmotions())
        case type.Default:
            listView?.setEmotions(tool.defaultEmotions!)
        case type.Emoji:
            listView?.setEmotions(tool.emojiEmotions!)
        case type.Lxh:
            listView?.setEmotions(tool.lxhEmotions!)
        default:
            break
        }
        
        
    }


    
}
