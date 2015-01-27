//
//  DreamEmotionKeyboard.swift
//  DreamWeibo
//
//  Created by 孙龙霄 on 1/26/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

import UIKit

struct DreamEmotionToolbarButtonType {
    
    let Recently = 501
    let Default = 502
    let Emoji = 503
    let Lxh = 504
}

class DreamEmotionKeyboard: UIView ,DreamEmotionToolbarProtocol{

    var listView:DreamEmotionListView?
    var toolbar:DreamEmotionToolbar?
    
    var defaultEmotions:NSArray?
    var emojiEmotions:NSArray?
    var lxhEmotions:NSArray?
    
    
    override init() {
        super.init()

    }

    func setDefaultEmotions(){
        let plist = NSBundle.mainBundle().pathForResource("EmotionIcons/default/info.plist", ofType: nil)
        self.defaultEmotions = DreamEmotion.objectArrayWithFile(plist)
        
        for emotion in self.defaultEmotions! {
            let emotiont = emotion as DreamEmotion
            emotiont.directory = "EmotionIcons/default/"
        }
        
    }

    func setEmojiEmotions(){
        let plist = NSBundle.mainBundle().pathForResource("EmotionIcons/emoji/info.plist", ofType: nil)
        self.emojiEmotions = DreamEmotion.objectArrayWithFile(plist)
        
        for emotion in self.emojiEmotions! {
            let emotiont = emotion as DreamEmotion
            emotiont.directory = "EmotionIcons/emoji/"
        }
        
    }

    func setLxhEmotions(){
        let plist = NSBundle.mainBundle().pathForResource("EmotionIcons/lxh/info.plist", ofType: nil)
        self.lxhEmotions = DreamEmotion.objectArrayWithFile(plist)
        
        for emotion in self.lxhEmotions! {
            let emotiont = emotion as DreamEmotion
            emotiont.directory = "EmotionIcons/lxh/"
        }

    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        listView = DreamEmotionListView()
        self.addSubview(listView!)
        
        toolbar = DreamEmotionToolbar()
        toolbar?.delegate = self
        self.addSubview(toolbar!)
        
        setDefaultEmotions()
        setEmojiEmotions()
        setLxhEmotions()
        toolbar?.selectDefaultButton()

    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func layoutSubviews() {
        super.layoutSubviews()
        self.listView?.frame = CGRectMake(0, 0, self.width(), self.height()-35)
    }

    
    func toolbarItemClick(button:UIButton){
        let type = DreamEmotionToolbarButtonType()
        switch(button.tag){
            
        case type.Recently:
            break
        case type.Default:
            listView?.setEmotions(defaultEmotions!)
        case type.Emoji:
            listView?.setEmotions(emojiEmotions!)
        case type.Lxh:
            listView?.setEmotions(lxhEmotions!)
        default:
            break
        }
        
        
    }


    
}
