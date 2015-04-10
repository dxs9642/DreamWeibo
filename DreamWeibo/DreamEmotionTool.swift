 //
//  DreamEmotionTool.swift
//  DreamWeibo
//
//  Created by 孙龙霄 on 1/28/15.
//  Copyright (c) 2015 孙龙霄. All rights reserved.
//

import UIKit

 struct DreamEmotionToolbarButtonType {
    
    let Recently = 501
    let Default = 502
    let Emoji = 503
    let Lxh = 504
 }
 
class DreamEmotionTool: NSObject {
   
    
    var defaultEmotions:NSArray?
    var emojiEmotions:NSArray?
    var lxhEmotions:NSArray?
    var recentEmotions = NSMutableArray()
    let recentFilePath =     (((NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true) as NSArray).lastObject as! NSString) as String)+"/recentEmotions.data"
    
    
    func setDefaultEmotions(){
        let plist = NSBundle.mainBundle().pathForResource("EmotionIcons/default/info.plist", ofType: nil)
        self.defaultEmotions = DreamEmotion.objectArrayWithFile(plist)
        
        for emotion in self.defaultEmotions! {
            let emotiont = emotion as! DreamEmotion
            emotiont.directory = "EmotionIcons/default/"
        }
        
    }
    
    func setEmojiEmotions(){
        let plist = NSBundle.mainBundle().pathForResource("EmotionIcons/emoji/info.plist", ofType: nil)
        self.emojiEmotions = DreamEmotion.objectArrayWithFile(plist)
        
        for emotion in self.emojiEmotions! {
            let emotiont = emotion as! DreamEmotion
            emotiont.directory = "EmotionIcons/emoji/"
        }
        
    }
    
    func setLxhEmotions(){
        let plist = NSBundle.mainBundle().pathForResource("EmotionIcons/lxh/info.plist", ofType: nil)
        self.lxhEmotions = DreamEmotion.objectArrayWithFile(plist)
        
        for emotion in self.lxhEmotions! {
            let emotiont = emotion as! DreamEmotion
            emotiont.directory = "EmotionIcons/lxh/"
        }
        
    }

    func getRecentEmotions()->NSArray{
        
        let result: AnyObject? = NSKeyedUnarchiver.unarchiveObjectWithFile(recentFilePath) as AnyObject?
        if result != nil {
            recentEmotions = result as! NSMutableArray
        }
        
        
     return recentEmotions
        
    }
    
    func addRecentEmotion(emotion:DreamEmotion){
        
        getRecentEmotions()
        recentEmotions.removeObject(emotion)
        recentEmotions.insertObject(emotion, atIndex: 0)
        NSKeyedArchiver.archiveRootObject(recentEmotions, toFile: recentFilePath)
        
    }
    
    
    
}
